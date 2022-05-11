# sidekiq_honeypot

This gem is a plugin to excon gem https://github.com/mperham/sidekiq .

This gem allows enqueueing jobs in sidekiq without defining their classes.

This gem is supposed to be only used with sidekiq and active job gems.

It only allows queuing activejob wrapped jobs!

## Examples

basic example without args:

    Sidekiq.perform_async('MyClass')

class name will be converted to string and camelized:

    Sidekiq.perform_async('my_class')
    Sidekiq.perform_async(:my_class)

this is how to pass args:

    Sidekiq.perform_async(:my_class, arg1)
    Sidekiq.perform_async(:my_class, arg1, arg2)

define custom queue (default queue is 'default'):

    Sidekiq.perform_async(:my_class, arg1, arg2, queue: :low)

schedule job at certain time:

    Sidekiq.perform_async(:my_class, arg1, arg2, queue: :low, at: Date.tomorrow.midnight)
    Sidekiq.perform_async(:my_class, arg1, arg2, queue: :low, at: 1.hour.from_now)

## License

MIT
