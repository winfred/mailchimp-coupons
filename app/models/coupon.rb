class Coupon < ActiveRecord::Base
  belongs_to :user
  before_create :create_merge_var
  before_destroy :destroy_merge_var
  before_update :update_merge_var_name

  def create_merge_var
    self.tag = "COUPON#{user.next_coupon_num}"
    user.api.listMergeVarAdd(id: list_id,tag: self.tag, name: name, options: {public: false,show:false, default_value: ''})
  end

  def destroy_merge_var
    user.api.listMergeVarDel(id: list_id, tag: tag)
  end
  
  def update
    user.api.listMergeVarUpdate(id: list_id, tag: tag, options: {name: self.name}) if name_changed?
  end

  def consume(email)
    response = user.api.listMemberInfo(id: list_id, email_address: email)
    result =  {response: "NotSubscribed", email: email} if not_subscribed?(response)
    result =  consume_and_respond(email) if subscribed_and_not_consumed?(response)
    result = {response: "AlreadyConsumed", email: email} if subscribed_and_consumed?(response)
    result
  end

  private
    def subscribed_and_not_consumed?(response)
      response['success'] == 1 and response['data'][0]['merges'][tag] != "consumed"
    end

    def subscribed_and_consumed?(response)
      response['success'] == 1 and response['data'][0]['merges'][tag] == "consumed"
    end

    def not_subscribed?(response)
      response['errors'] == 1
    end
    
    def consume_and_respond(email)
      user.api.listUpdateMember(id: list_id, email_address: email, merge_vars: {"#{tag}" => 'consumed'})
      {response: "Consumed", email: email}
    end
end
