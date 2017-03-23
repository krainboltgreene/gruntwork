class OrdersMailer < ApplicationMailer
  def claimed(owner, order)
    @owner = owner
    @order = order
    mail(to: order.requester.email, subject: "#{owner.name} has claimed your request")
  end

  def finished(owner, order)
    @owner = owner
    @order = order
    mail(to: order.requester.email, subject: "#{owner.name} has finished your request")
  end

  def urgent(watcher, order)
    @requester = order.requester
    @order = order
    mail(to: watcher.email, subject: "URGENT: A new order was created")
  end

  def responded(author, order, response)
    @author = author
    @order = order
    @response = response
    mail(to: order.requester.email, subject: "#{author.name} has responded to your request")
  end
end
