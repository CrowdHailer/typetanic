# Typetanic

**All the goodness of dedicated value objects ready to go**

Typetanic defines a collection of ruby value objects that occur across many types of applications. The collection is growing, included so far are:

- [email](https://github.com/CrowdHailer/typtanic#user-content-email)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'typetanic', :require => false
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install typetanic
```

## Usage

It is recommended NOT to require the whole of typetanic. It is unlikely all the types will be relevant. It is also recommended to subclass each type to a namespace appropriate to your domain*. This has several benefits.

- Extensions can be made without monkey patching the library class.
- The typetanic version can be swapped out with minimal knock on effect.
- The subclass can have a more appropriate name.

*This is why all types are in the Typetanic namespace, see this [post](http://insights.workshop14.io/2015/05/28/ruby-require-and-broad-modules.html) for more details*

*email_address.rb*
```rb
require 'typetanic/email'

class EmailAddress < Typetanic::Email
  # Any custom code to extend the email class can be added here.
  # For example querying if the email address is local to the company.

  def internal?
    hostname == 'workshop14.io'
  end
end
```

## Included Types

### Email

Represents email addresses.
- Initialization strips leading and trailing whitespace
- It is an invalid email without and '@' symbol
- It is also invalid with more than one '@''symbol

Makes available the following parts of the address

```rb
email = Typetanic::Email.new 'name@example.com'

email.local_part
# => "name"

email.hostname
# => "example.com"

email.domains
# => ["com", "example"]

email.top_level_domain
# => "com"
```

Emails are ordered by their domains from top level down before being ordered by the local part.

Email validation is not simple, advanced validation does not guarentee an email exists. For this reason the type has only simple validation. For more information check out the [isemail site](http://isemail.info/about) or [wikipedia page](http://en.wikipedia.org/wiki/Email_address)

## Custom Types

Typtanic exists to reduce some of the startup time with specifying domain objects for all parts of your system. This can be time consuming particuarly early on when requirements are changing rapidly. Use these types when generic types are appropriate or most time effective.

The included types come with no configuration options. If you find the type is no longer appropriate for your domain it should be switched out for a custom object. This should be trivial if the advice in the usage section is followed.

The rest of this section contains resources useful for building robust custom types.

#### String coercion
http://briancarper.net/blog/98/

#### Equality
http://stackoverflow.com/questions/7156955/whats-the-difference-between-equal-eql-and

#### Comparability

#### Immutability
All value objects should be treated as immutable. At the moment I prefer complying with the contract that I will not mutate value objects. Ruby allows most things an ensuring immutability requires a few tricks.

#### Singletons

sets with limited types, e.g. months, http verbs will return the same object when creating new instances.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/typetanic/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
Probably should go for immutability so hand out copies when querying string

## Misc
Stuff beyond here are notes and thoughts relating to ongoing development

#### Immutability
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

Think decided ArgumentError best as [].fetch 1 throws IndexError and {}.fetch :a throws KeyError

##### Stash
Adds a `stash` and `load` method to reduce the type to a primitive that can be stored in a database. Normally the same as `to_s` and `new` but added here for unusual situations.
