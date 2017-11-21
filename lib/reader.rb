require 'pry'

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

    attr_reader :lines, :params, :header, :exclude_characters, :errors

    def initialize(filename:, params: {}, exclude_characters: nil)
      @filename = filename
      @params   = params
      @exclude_characters = exclude_characters
      @errors = []
    end

    def read
      read_file
      filter_rows
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

      @header = lines[header_row].split
      @lines  = lines[range_rows]
    end

    def range_rows
      (start_row..end_row)
    end

    def validate_filter!
      raise InvalidRowPositionError unless lines[range_rows] && lines[header_row]
    end

    def remove_words
      @lines = lines.reject!{|line| line.include?(@exclude_characters)}
    end

    def header_row
      params[:header_row] || 0
    end

    def start_row
      params[:start_row] || 1
    end

    def end_row
      params[:end_row] || -1
    end
  end
end
