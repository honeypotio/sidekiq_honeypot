# sidekiq_honeypot

This gem is a plugin to sidekiq gem https://github.com/mperham/sidekiq .

This gem allows enqueueing jobs in sidekiq without defining their classes.

This gem is can be used used with sidekiq alone or with active job wrappers.

## Usage

- Use `perform_async` to enqueue sidekiq job.
- Use `perform_later` to enqueue activejob job.

## Examples

basic example without args:

execute sidekiq job

    Sidekiq.perform_async('MyClass')

execute activejob job

    Sidekiq.perform_later('MyClass')

class name will be converted to string and camelized:

    Sidekiq.perform_later('my_class')
    Sidekiq.perform_later(:my_class)

this is how to pass args:

    Sidekiq.perform_later(:my_class, arg1)
    Sidekiq.perform_later(:my_class, arg1, arg2)

define custom queue (default queue is 'default'):

    Sidekiq.perform_later(:my_class, arg1, arg2, queue: :low)

keyword args are also supported:

    Sidekiq.perform_later(:my_class, 5, admin: true, queue: :low)

schedule job at certain time:

    Sidekiq.perform_later(:my_class, arg1, arg2, queue: :low, at: Date.tomorrow.midnight)
    Sidekiq.perform_later(:my_class, arg1, arg2, queue: :low, at: 1.hour.from_now)

## License

MIT
