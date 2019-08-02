# Hydrochlorb

Provide a similar way to config HCL (HashiCorp Configuration Language) in ruby.
And featuring all programming features (variables, iterators, functions, regexp, etc) in ruby.

## Installation

Add the following lines to Gemfile:

    gem 'hydrochlorb'

And execute:

    $ bundle install

Or just install directly by:

    $ gem install hydrochlorb

## Usage

```ruby
int = 1
float = 1.23
str = 'foo'
t = true
f = false

builder = Hydrochlorb.build do
  it_is_integer int
  it_is_negtive_integer int * -1
  it_is_float float
  it_is_negtive_float float * -1
  it_is_string str
  it_is_true t
  it_is_false f
  it_is_array (1..10).to_a
end

builder.build do
  it_is_array_object do
    it_is_also_array_object {
      something_inside_object "#{str} bar"
    }
  end

  it_is_object "obj" do
    it_is_object_with_multiple_keys "in", str do
      something_inside_object str.gsub(/f/, 'b')
    end
  end
end

puts builder.to_hcl
```

Will output:

```hcl
it_is_integer = 1
it_is_negtive_integer = -1
it_is_float = 1.23
it_is_negtive_float = -1.23
it_is_string = "foo"
it_is_true = true
it_is_false = false
it_is_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
it_is_array_object {
  it_is_also_array_object {
    something_inside_object = "foo bar"
  }
}
it_is_object "obj" {
  it_is_object_with_multiple_keys "in" "foo" {
    something_inside_object = "boo"
  }
}

```

Or you also can use the following style to avoid conflicted name or change indentation:

```ruby
builder = Hydrochlorb.build do
  add :to_s, 'this is not defualt to_s method.'
  add :Object, 'obj' do
    add :Array do
      add :Boolean, true
    end
  end
end

puts builder.to_hcl(indent: 4)
```

will output:

```hcl
to_s = "this is not defualt to_s method."
Object "obj" {
    Array {
      Boolean = true
    }
}
```
