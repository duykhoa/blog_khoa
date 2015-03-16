class EmailSubscribe < ActiveRecord::Base
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  #after_create :subscribe

  protected

  def subscribe
    gb = Gibbon::API.new(BlogSetting.mailchimp_api, {timeout: '30'})

    gb.lists.subscribe(
      {
        id: BlogSetting.mailchimp_list,
        email: {email: email},
        merge_vars: {FNAME: 'Subscriber First Name', LNAME: 'Subscriber Last Name'},
        double_optin: false}
    )
  end
end
