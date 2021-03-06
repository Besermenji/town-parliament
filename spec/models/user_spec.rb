# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#

require 'spec_helper'

describe User do

  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:encrypted_password).of_type(:string) }
  it { should have_db_column(:reset_password_token).of_type(:string) }
  it { should have_db_column(:remember_created_at).of_type(:datetime) }
  it { should have_db_column(:sign_in_count).of_type(:integer) }
  it { should have_db_column(:current_sign_in_at).of_type(:datetime) }
  it { should have_db_column(:last_sign_in_at).of_type(:datetime) }
  it { should have_db_column(:current_sign_in_ip).of_type(:string) }
  it { should have_db_column(:last_sign_in_ip).of_type(:string) }

  it { should have_and_belong_to_many(:roles) }

  let(:user) { create(:user) }

  let(:admin_role) { create(:role, :name => "admin") }
  let(:customer_role) { create(:role, :name => "customer") }

  describe ".role?" do

    context "user has asked role" do

      before do
        user.roles.clear
        user.roles << admin_role
      end

      it "returns true" do
        user.role?(admin_role.name).should be_truthy
      end

    end

    context "user doesn't have asked role" do

      before do
        user.roles.clear
        user.roles << customer_role
      end

      it "returns false" do
        user.role?(admin_role.name).should be_falsey
      end

    end

  end

  describe ".make_admin" do

    before do
      Role.find_or_create_by(:name => "admin")
      user.make_admin
    end

    it "adds admin role to user" do
      user.should be_admin
    end

  end

  describe ".revoke_admin" do

    before do
      Role.find_or_create_by(:name => "admin")
      user.make_admin
      user.revoke_admin
    end

    it "removes admin role from user" do
      user.should_not be_admin
    end

  end

  describe ".admin?" do

    before do
      user.roles.clear
    end

    it "returns true if user is admin" do
      user.roles << admin_role
      user.admin?.should be_truthy
    end

    it "returns false is user is not admin" do
      user.roles << customer_role
      user.admin?.should be_falsey
    end

  end

end
