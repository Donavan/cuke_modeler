module CukeModeler

  # A class modeling a Cucumber Examples table row.

  class Row

    include Sourceable
    include Raw
    include Nested


    # The cells that make up the row
    attr_accessor :cells


    # Creates a new Row object and, if *source* is provided, populates
    # the object.
    def initialize(source = nil)
      parsed_row = process_source(source)

      @cells = []

      build_row(parsed_row) if parsed_row
    end

    # Returns a gherkin representation of the row.
    def to_s
      "| #{cells.join(' | ')} |"
    end


    private


    def process_source(source)
      case
        when source.is_a?(String)
          parse_row(source)
        else
          source
      end
    end

    def parse_row(source_text)
      base_file_string = "Feature: Fake feature to parse\nScenario Outline:\n* fake step\nExamples: fake examples\n#{source_text}\n"
      source_text = base_file_string + source_text

      parsed_file = Parsing::parse_text(source_text, 'cuke_modeler_stand_alone_row.feature')

      parsed_file.first['elements'].first['examples'].first['rows'].last
    end

    def build_row(parsed_row)
      populate_element_source_line(parsed_row)
      populate_row_cells(parsed_row)
      populate_raw_element(parsed_row)
    end

    def populate_row_cells(parsed_row)
      @cells = parsed_row['cells']
    end

  end
end
