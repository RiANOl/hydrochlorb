describe Hydrochlorb do
  it 'can handle primitive types' do
    hcl = Hydrochlorb.build do
      it_is_integer 1
      it_is_negtive_integer -1
      it_is_float 1.23
      it_is_negtive_float -1.23
      it_is_string 'foo'
      it_is_null nil
      it_is_true true
      it_is_false false
      it_is_array [1, -2, 3.3, -4.4, 'bar', nil, true, false]
    end.to_hcl

    expect(hcl).to eq <<~EOF.chomp
      it_is_integer = 1
      it_is_negtive_integer = -1
      it_is_float = 1.23
      it_is_negtive_float = -1.23
      it_is_string = "foo"
      it_is_true = true
      it_is_false = false
      it_is_array = [1, -2, 3.3, -4.4, "bar", true, false]
    EOF
  end

  it 'can handle array object' do
    hcl = Hydrochlorb.build do
      it_is_array_object {
        foo 'bar'
      }
    end.to_hcl

    expect(hcl).to eq <<~EOF.chomp
      it_is_array_object {
        foo = "bar"
      }
    EOF
  end

  it 'can handle empty array object' do
    hcl = Hydrochlorb.build do
      it_is_array_object {
      }
    end.to_hcl

    expect(hcl).to eq <<~EOF.chomp
      it_is_array_object {
      }
    EOF
  end

  it 'can handle object' do
    hcl = Hydrochlorb.build do
      it_is_object 'obj' do
        foo 'bar'
      end
    end.to_hcl

    expect(hcl).to eq <<~EOF.chomp
      it_is_object "obj" {
        foo = "bar"
      }
    EOF
  end

  it 'can handle empty object' do
    hcl = Hydrochlorb.build do
      it_is_object 'obj' do
      end
    end.to_hcl

    expect(hcl).to eq <<~EOF.chomp
      it_is_object "obj" {
      }
    EOF
  end

  it 'can handle object with multiple keys' do
    hcl = Hydrochlorb.build do
      it_is_object 'o', 'b', 'j' do
        foo 'bar'
      end
    end.to_hcl

    expect(hcl).to eq <<~EOF.chomp
      it_is_object "o" "b" "j" {
        foo = "bar"
      }
    EOF
  end

  it 'can handle nested data types' do
    hcl = Hydrochlorb.build do
      foo 'bar'
      obj 'nested', 'obj' do
        obj 'obj', 'in', 'obj' do
          float 3.14
          arr {
            int 123
          }
          arr {
            bool true
            arr_in_arr {
              bool false
            }
          }
        end
      end
    end.to_hcl

    expect(hcl).to eq <<~EOF.chomp
      foo = "bar"
      obj "nested" "obj" {
        obj "obj" "in" "obj" {
          float = 3.14
          arr {
            int = 123
          }
          arr {
            bool = true
            arr_in_arr {
              bool = false
            }
          }
        }
      }
    EOF
  end

  it 'can handle multiple builds' do
    builder = Hydrochlorb.build do
      obj {
        first 1
      }
    end

    hcl = builder.build do
      second 2
    end.to_hcl

    expect(hcl).to eq <<~EOF.chomp
      obj {
        first = 1
      }
      second = 2
    EOF
  end

  it 'can serialize with different indent' do
    hcl = Hydrochlorb.build do
      foo 'bar'
      obj 'nested', 'obj' do
        obj 'obj', 'in', 'obj' do
          float 3.14
          arr {
            int 123
          }
          arr {
            bool true
          }
        end
      end
    end.to_hcl(indent: 4)

    expect(hcl).to eq <<~EOF.chomp
      foo = "bar"
      obj "nested" "obj" {
          obj "obj" "in" "obj" {
              float = 3.14
              arr {
                  int = 123
              }
              arr {
                  bool = true
              }
          }
      }
    EOF
  end
end
