class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  #use these to ban access from the url, as link ban is already in place.
  def new?
    #if you set rader here then only reader is going to have accss.
    user_is_a_reader?
  end

  def create?
    user_is_a_reader?
  end

  def show?
    user_isnot_a_reader?
  end

  def index?
    user_isnot_a_reader?
  end

  def edit?
    user_isnot_a_reader?
  end

  def update?
    user_isnot_a_reader?
  end

  def destroy?
    user_isnot_a_reader?
  end

  private
  def user_is_a_reader?
    @user.role == 'reader'
  end

  def user_isnot_a_reader?
    @user.role != 'reader'
  end
end
