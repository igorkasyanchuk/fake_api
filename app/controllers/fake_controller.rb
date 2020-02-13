class FakeController < ApplicationController

  def data
    result = FakeApi::Handler.handle(request.method, path: params[:path], params: params, headers: request.headers)

    response.status = result.status

    result.headers.each { |k, v| headers[k.to_s] = v }
    result.cookies.each { |k, v| cookies[k.to_s] = v }
    result.session.each { |k, v| session[k.to_s] = v }

    respond_to do |format|
      format.html { render plain: result.data.inspect }
      format.xml  { render xml: result.data }
      format.json { render json: result.data }
      format.js   { render js: result.data }
    end
  end

end