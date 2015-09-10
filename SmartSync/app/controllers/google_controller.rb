class GoogleController < ApplicationController

  def oauth
    redirect_to "https://accounts.google.com/o/oauth2/auth?client_id=#{ENV['CLIENT_ID']}&response_type=code&scope=openid%20email&redirect_uri=http://localhost:9393/google/oauth/redirect&state=#{ENV['STATE']}"
  end

  def token
    # console_alert({ title: "GET '/oauth/google/redirect'",
    #                        message: "Parameters Sent to Google",
    #                        parameters: params })

    if params[:state] != ENV['STATE']
      # console_alert({ title: "Oauth 'STATE' Validation Alert",
      #                        message: "Oauth 'STATE' Validation Does Not Match\nPotential Hacker Warning" })
    else
      # console_alert({ title: "Oauth 'STATE' Validation Passed" })
    end

    options = { code: params[:code],
                redirect_uri: "http://localhost:9393/google/oauth/redirect",
                client_id: ENV['CLIENT_ID'],
                client_secret: ENV['CLIENT_SECRET'],
                grant_type: "authorization_code"
              }

    token = HTTParty.post("https://www.googleapis.com/oauth2/v3/token", body: options)

    token = token.parsed_response["access_token"]
    expires = token.parsed_response["expires_in"]
    uid = token.parsed_response["id_token"]

    response = HTTParty.get("https://www.googleapis.com/oauth2/v3/userinfo", headers: { "Authorization" => "Bearer #{token}" })

    console_alert({ title: "Google Oauth User Info Response",
                    parameters: response.parsed_response })

    user = update_user_from_oauth(response.parsed_response, token, expires, uid)

    console_alert({ title: "User Successfully Logged In",
                    arameters: { user_id: user.id } })

    oauth_login(user.id, token)

    status 200
    redirect "/user/#{user.id}"

  end

  private

  def oauth_update_user(args, token, expires, uid)
    user = User.find_by(email: args.fetch("email")) || User.new(email: args.fetch("email"))
    user.name = args.fetch("name")
    user.first_name = args.fetch("given_name")
    user.last_name = args.fetch("family_name")
    user.picture = args.fetch("picture")
    user.token = token
    user.password = token
    user.expires = expires
    user.uid = uid

    user.save
    return user
  end

  def oauth_login(user_id, token)
    session[:user_id] = user_id
    session[:access_token] = token
  end

  def oauth_logged_in?
    !!session[:user_id]
  end


end
