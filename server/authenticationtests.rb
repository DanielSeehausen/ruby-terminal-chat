module AuthenticationTests

  #TODO: instead of using discrete values for valid responses, tests should pass as functions or prompts with validation functions that incapsulate their own validation methods
  TESTS = [{ :prompt => "Were you a class, and were Steven your super, what additional methods would you need to be considered a master programmer?", :answers => ["none", "0", "00", "zero", "nil", "false"]},
  { :prompt => "'Conan, what is best in life?'\n 'To crush your enemies, see them driven before, and to bask in the glory of ______!'", :answers => ["steven", "stephen", "steve", "master", "the master", "steven nunez"]},
  { :prompt => "'I know what you're thinking. Did he fire six shots or only five? Well, you've got to ask yourself one question: 'Do I feel ______?' Well, do ya, punk?'", :answers => ["steven", "stephen", "steve", "master", "the master", "steven nunez"]}].freeze

end
