# frozen_string_literal: true

module Sidekiq
  def self.perform_async(klass, *arguments, **kwargs)
    queue = kwargs.delete(:queue) || 'default'
    at = kwargs.delete(:at)
    arguments.push(kwargs) unless kwargs.empty?

    klass = klass.to_s.camelize

    args = ActiveJob::Base.new.serialize.merge(
      'job_class' => klass,
      'queue_name' => queue.to_s,
      'arguments' => arguments
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
