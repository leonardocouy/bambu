module Bambu
  class InvalidRowPositionError < StandardError
  end

  class FileNotFoundError < StandardError
  end

  class Reader
    # 1. Ler o arquivo
    # 2. Excluir caracteres que não desejo no arquivo
    # 3. Quero especificar de que linha começar até o término
    # 4. Quero especificar ou não qual é a linha de coluna

    ### REFATORAR ESSE TREM!!!!

    attr_reader :lines, :header, :exclude_characters, :errors

    def initialize(filename:, exclude_characters: nil, filter: false, header_row: 0, start_row: 1, end_row: -1)
      @filename = filename
      @filter = filter
      @header_row = header_row
      @start_row, @end_row = start_row, end_row
      @exclude_characters = exclude_characters
      @errors = []
    end

    def read
      read_file
      filter_rows if @filter
      remove_words unless exclude_characters.nil?
      lines
    end

    private

    def read_file
      begin
        @lines = File.readlines(@filename)
      rescue Errno::ENOENT
        raise FileNotFoundError
      end
    end

    def filter_rows
      validate_filter!

      @header = lines[@header_row].split
      @lines  = lines[@start_row..@end_row]
    end

    def validate_filter!
      raise InvalidRowPositionError if lines[@start_row].nil? || lines[@end_row].nil? || lines[@header_row].nil?
    end

    def remove_words
      @lines = lines.reject!{|line| line.include?(@exclude_characters)}
    end
  end
end
