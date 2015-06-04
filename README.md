# Typetanic

**All the goodness of dedicated domain objects ready to go**

### Introduction

These are all part of my drive to use more domain specific objects. I understand the irony of having domain objects before the domain, these have just been a few useful ones that come up repeatedly.

*NOTE: If the object you want is not like the object defined here write your own. Or wrap with an adapter*

Comparison

All types are value objects, an instance's identity is characterized it's external attributes.

Immutability

All types should be treated as immutable objects. However at the moment I prefer complying with the contract that I will not mutate them than perfoming any trickery to ensure that they are not mutatable

Singletons

sets with limited types, e.g. months, http verbs will return the same object when creating new instances.

### Protocol
The types in this gem implement a few non standard methods that
##### Forge
The forge method takes the same arguments as an object's `new` method. In addition if the creation of a new object fails due to invalid input then the exception is caught and passed to a block. This is useful whenever you have a mechanism ready to handle that failure. It is synonymous with a hash's `fetch` method.

```rb
hash.fetch(:item)
# This is important and I don't know what to do if its missing
hash.fetch(:item) { NullItem.new }
# I want this but if it is missing I have a backup plan
```

```rb
Email.forge('bad')
# !! Typetanic::ForgeError
# Nuts this is bad and I don't have a solution, fail with error

Email.forge('bad') do |error|
  # I know what to do with this error.

  # report it
  puts error.message

  # return null item
  NullEmail.new
end
```

**Questions**
- I don't know if forge should catch ArgumentError's or Typetanic::Invalid's the first allows the mixin to be used in any class.
- I don't know if forge without a block should reraise the exisiting error or return a specific ForgeError
- I would be tempted to privatise the `new` method after creating forge as it is the new method that will correctly handle singleton objects. In addition it's easy to use new through habit, which is probably not wanted after including a forge method.


##### Stash
Adds a `stash` and `load` method to reduce the type to a primitive that can be stored in a database. Normally the same as `to_s` and `new` but added here for unusual situations.


## Included
1. Email
2. title
3. name
4. month

core extensions

#### Email
Email validation is a tricky topic

http://isemail.info/about

http://en.wikipedia.org/wiki/Email_address

https://github.com/mikel/mail/blob/master/lib/mail/elements/address.rb

> local@hostname
> username@domain.toptevel.domain

hostnames are well defined on wikipedia
the whole email and local part less so.

Probably should go for immutability so hand out copies when querying string

#### Boolean
The boolean class is odd in that it returns true or false and not instances

#### Integer

```rb
class Frozen
  def initialize(value)
    define_singleton_method :value do
      value
    end
    freeze
  end

end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'typetanic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install typetanic

## Usage

TODO: Write usage instructions here

## Docs
#### Most types
*These are implemented on the majority of types unless it does not make sense*

## Contributing

1. Fork it ( https://github.com/[my-github-username]/typetanic/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
