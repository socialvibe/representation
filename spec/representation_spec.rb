require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'ruby-debug'

describe "Representation" do
  before(:each) { load File.dirname(__FILE__) + '/support/models.rb' }
  after(:each) { destroy_models }
  
  it "should make available the representation class method" do
    User.should respond_to :representation
  end
  
  describe ".representation" do
    it "should add the first argument to the list of representation names" do
      User.representation :public, :name, :calculated_age
      User.representation_names.should == [:public]
    end
    
    it "should add the rest of the arguments to the list of representation values" do
      User.representation :public, :name, :calculated_age
      User.values_for_representation(:public).should == [:name, :calculated_age]
    end
    
    it "should attach representations to the appropriate class" do
      User.representation :public, :name, :calculated_age
      User.representations.should == {:public => [:name, :calculated_age]}
      Address.representations.should == {}
    end
  end
  
  describe "#representation" do
    it "should return the same type of object as the receiver" do
      User.representation :public, :name, :calculated_age
      instance = User.new(:name => 'Tweedle Dum', :age => 42)
      instance.representation(:public).should be_an_instance_of(User)
    end
    
    it "should be accessible via the 'as' alias" do
      pending "equality broken" do
        User.representation :public, :name, :calculated_age
        instance = User.new(:name => 'Tweedle Dum', :age => 42)
        instance.representation(:public).should == instance.as(:public)
      end
    end
    
    it "should raise a Representation::UnknownRepresentationError when referencing an unknown representation" do
      expect{ User.new.representation(:invalid) }.to raise_error Representation::UnknownRepresentationError
    end
    
    it "should return an object with only the attributes identified by the representation definition" do
      User.representation :public, :name, :calculated_age
      user = User.new(:name => 'Tweedle Dum', :age => 42)
      public_user = user.representation(:public)
      public_user.name.should == 'Tweedle Dum'
      public_user.calculated_age.should == 84
      lambda { public_user.ssn }.should raise_error(NoMethodError)
    end
  end
  
  describe "the representation object" do
    before(:each) { User.representation :public, :name, :calculated_age }
    let(:user) { User.new(:name => 'Tweedle Dum', :age => 42) }
    let(:representation) { user.representation(:public) }
    
    it "should be inspectable" do
      representation.inspect.should == "#<#{User} name: \"Tweedle Dum\", calculated_age: 84>"
    end
    
    it "should not modify the resource off of which the representation is based when the representation is modified" do
      representation.name = 'Tweedle Dee'
      user.name.should == 'Tweedle Dum'
    end
    
    it "should be serializable as a hash" do
      representation.serializable_hash.should == {"calculated_age" => 84, "name" => "Tweedle Dum"}
    end
    
    it "should be serializable to json" do
      representation.to_json.should == "{\"calculated_age\":84,\"name\":\"Tweedle Dum\"}"
    end
    
    it "should be serializable to xml" do
      # note: broken with rails 3.0.9, working with 3.1rc
      
      representation.to_xml.should match \
        /\A<\?xml.*?>\s*<user>\s*<name>Tweedle Dum<\/name>\s*<calculated-age.*>84<\/calculated-age>\s*<\/user>\s*\Z/m        
      
      # TODO: remove type=NilClass attribute from calculated-age node
      # representation.to_xml.should match \
      #   /\A<\?xml.*?>\s*<user>\s*<name>Tweedle Dum<\/name>\s*<calculated-age>84<\/calculated-age>\s*<\/user>\s*\Z/m
    end
    
    it "should handle a nested representation (has_one)" do
      User.representation :mailto, :name, :address
      Address.representation :mailto, :street, :number
      user.address = Address.new(:number => '1234', :street => 'SomeStreet')
      user.representation(:mailto).to_json.should == \
        "{\"address\":{\"number\":\"1234\",\"street\":\"SomeStreet\"},\"name\":\"Tweedle Dum\"}"
    end
    
    it "should handle a nested representation (has_many)" do
      User.representation :professional, :name, :titles
      Title.representation :professional, :description
      user.titles << Title.new(:description => "Peon", :base_salary => 20000)
      user.titles << Title.new(:description => "Chief officer of awesome", :base_salary => 400000)
      user.representation(:professional).to_json.should == \
        "{\"name\":\"Tweedle Dum\",\"titles\":[{\"description\":\"Peon\"},{\"description\":\"Chief officer of awesome\"}]}"
    end
  end
end
