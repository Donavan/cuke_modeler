module CukeModeler

  # A class modeling a Cucumber .feature file.

  class FeatureFile < ModelElement

    include Containing

    # The file path of the modeled feature file
    attr_accessor :path

    # The Feature object contained by the FeatureFile
    attr_accessor :feature


    # Creates a new FeatureFile object and, if *file_parsed* is provided,
    # populates the object.
    def initialize(file_parsed = nil)
      @path = file_parsed || ''

      if file_parsed
        raise(ArgumentError, "Unknown file: #{file_parsed.inspect}") unless File.exists?(file_parsed)

        parsed_file = parse_file(file_parsed)

        build_file(parsed_file)
      end
    end

    # Returns the name of the modeled file.
    def name
      File.basename(@path.gsub('\\', '/'))
    end

    # Returns the immediate child elements of the file(i.e. its Feature object).
    def contains
      [@feature]
    end

    # Returns the path of the modeled feature file.
    def to_s
      @path
    end


    private


    def parse_file(file_to_parse)
      source_text = IO.read(file_to_parse)

      Parsing::parse_text(source_text)
    end

    def build_file(parsed_file)
      @feature = build_child_element(Feature, parsed_file.first) unless parsed_file.empty?
    end

  end
end