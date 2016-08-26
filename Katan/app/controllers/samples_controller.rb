class SamplesController < ApplicationController
  def index
    @sample = Sample.new
  end

  def create
    sample = Sample.new params.require(:sample).permit(:name)
    @result = sample.save ? 'success' : 'failed'
  end

  def sub1
    @result = 'ok'
  end

  def sub2
    @samples = Sample.all
  end
end
