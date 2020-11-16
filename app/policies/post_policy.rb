class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end


  #use these to ban access from the url, as link ban is already in place.
  def new?
    #if you set rader here then only reader is going to have accss.
    @user.role == 'author'
  end

  def create?
    @user.role == 'author'
  end

  def show?
  end

  def edit?
    @user.role != 'reader'
  end

  def update?
    @user.role != 'reader'
  end

  def destroy?
    @user.role != 'reader'
  end

  # private

  # def user_is_admin_or_author?
  # end

  # def user_is_author?
  # end

end
