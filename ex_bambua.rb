class Bambu
  attr_reader :header, :lines

  def initialize(filename:, start_row: 1, end_row: -1, header_row: 0, exclude_row: nil,
                 exclude_columns: nil)
    @filename         = filename
    @start_row        = start_row
    @end_row          = end_row
    @header_row       = header_row
    @exclude_row      = exclude_row
    @exclude_columns  = exclude_columns
  end

  def read
    read_data
    exclude_rows unless @exclude_row.nil?
    split_lines_to_columns
    exclude_columns unless @exclude_columns.nil?
    normalize
  end

  def min(column_name:)
    lines.min { |previousLine, currentLine|
      previousLine[column_name] <=>  currentLine[column_name]
    }
  end

  private

  def read_data
    file = File.readlines(@filename)
    @header = file[@header_row].split
    @lines = file[@start_row..@end_row]
  end

  def exclude_rows
    lines.reject!{|line| line.include?(@exclude_row)}
  end

  def split_lines_to_columns
    lines.map!(&:split).delete_if(&:empty?)
  end

  def normalize
    lines.map!{|line|
      line.map.with_index{|value, index|
        Hash[header[index].to_sym, value]
      }.reduce({}, :merge)
    }
  end

  def exclude_columns
    lines.map!{|line|
      line.reject.with_index{|_value, index|
        @exclude_columns.include?(index)
      }
    }
  end
end
