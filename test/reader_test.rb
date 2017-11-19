require 'helper'
require_relative '../reader'

describe Bambu::Reader do

  def with_file(content)
    File.open('test.dat', 'w') do |file|
      file.puts(content)
    end

    results = yield

    File.delete('test.dat')

    results
  end

  describe '#read' do
    describe 'valid params' do
      it 'reads line from specified file' do
        lines = with_file("returning...") do
          reader = Bambu::Reader.new(filename: 'test.dat')
          reader.read
        end

        expect(lines).must_equal ["returning...\n"]
      end

      describe 'with exclude characters' do
        it 'removes specified characters from lines' do
          lines = with_file("DELETE THIS!!!!!!\nreturning...") do
            exclude_characters = 'DELETE THIS!!!!!!'
            reader = Bambu::Reader.new(filename: 'test.dat', exclude_characters: exclude_characters)
            reader.read
          end

          expect(lines).must_equal ["returning...\n"]
        end
      end

      describe 'with selected rows' do
        it 'reads header line' do
          content = <<~EOF
            id nome_completo
            1 leo
            fim
          EOF

          reader = with_file(content) do
            reader = Bambu::Reader.new(filename: 'test.dat', filter: true, header_row: 0)
            reader.read
            reader
          end

          expect(reader.header).must_equal ["id", "nome_completo"]
        end

        it 'reads first line' do
          content = <<~EOF
            ------------
            começo
            meio
            fim
          EOF

          lines = with_file(content) do
            reader = Bambu::Reader.new(filename: 'test.dat', filter: true, start_row: 1)
            reader.read
          end

          expect(lines[0]).must_equal "começo\n"
        end

        it 'reads end line' do
          content = <<~EOF
            ------------
            começo
            meio
            fim
            fim falso
          EOF

          lines = with_file(content) do
            reader = Bambu::Reader.new(filename: 'test.dat', filter: true, start_row: 1, end_row: -2)
            reader.read
          end

          expect(lines[-1]).must_equal "fim\n"
        end
      end
    end

    describe 'invalid params' do
      it 'raises FileNotFoundError' do
        filename = 'invalid_filename.dat'

        -> do
          reader = Bambu::Reader.new(filename: filename)
          reader.read
        end.must_raise Bambu::FileNotFoundError
      end

      describe 'when is an invalid index' do
        describe 'with invalid start_row' do
          it 'raises InvalidRowPositionError' do
            content = <<~EOF
              começo
              meio
              fim
            EOF

            -> do
              with_file(content) do
                reader = Bambu::Reader.new(filename: 'test.dat', filter: true, start_row: 40)
                reader.read
              end
            end.must_raise Bambu::InvalidRowPositionError
          end
        end

        describe 'with invalid end_row' do
          it 'raises InvalidRowPositionError' do
            content = <<~EOF
              começo
              meio
              fim
            EOF

            -> do
              with_file(content) do
                reader = Bambu::Reader.new(filename: 'test.dat', filter: true, start_row: 1, end_row: 60)
                reader.read
              end
            end.must_raise Bambu::InvalidRowPositionError
          end
        end

        describe 'with invalid header_row' do
          it 'raises InvalidRowPositionError' do
            content = <<~EOF
              id nome_completo
              1 leo
              fim
            EOF

            -> do
              with_file(content) do
                reader = Bambu::Reader.new(filename: 'test.dat', filter: true, header_row: 90)
                reader.read
              end
            end.must_raise Bambu::InvalidRowPositionError
          end
        end
      end
    end
  end
end
