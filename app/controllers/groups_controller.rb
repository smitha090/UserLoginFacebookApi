class GroupsController < ApplicationController
    def index
        @user = current_user
        @groups = @user.groups
    end    
end    