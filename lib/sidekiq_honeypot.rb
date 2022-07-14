# frozen_string_literal: true

module Sidekiq
  def self.perform_async(klass, *arguments, **kwargs)
    queue = kwargs.delete(:queue) || 'default'
    at = kwargs.delete(:at)

    klass = klass.to_s.camelize

    arguments.push(kwargs) unless kwargs.empty?

    push_args = {
      'class' => klass,
      'queue' => queue.to_s,
      'args' => arguments
    }

    push_args['at'] = at.to_f if at

    Sidekiq::Client.push(push_args)
  end

  def self.perform_later(klass, *arguments, **kwargs)
    queue = kwargs.delete(:queue) || 'default'
    at = kwargs.delete(:at)

    klass = klass.to_s.camelize

    args = ActiveJob::Base.new(*arguments, **kwargs).serialize.merge(
      'job_class' => klass,
      'queue_name' => queue.to_s
    )

    push_args = {
      'class' => ActiveJob::QueueAdapters::SidekiqAdapter::JobWrapper,
      'wrapped' => klass,
      'queue' => queue.to_s,
      'args' => [args]
    }

    push_args['at'] = at.to_f if at

    Sidekiq::Client.push(push_args)
  end
end
