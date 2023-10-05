class OrganizationsController < ApplicationController

    def create
        @user = User.find(params[:user_id])
        @organization = @user.organizations.build(organization_params)
        respond_to do |format|
            if @organization.save
                format.turbo_stream do
                    render turbo_stream: [
                        turbo_stream.replace('organizations-list',partial: "organizations/organizations_list", locals: {organizations: @user.organizations}),
                        turbo_stream.replace("form",partial: "organizations/form", locals: {url: user_organizations_path(@user)})

                    ]
                end
            end
        end
    end

    def show
        @organization = Organization.find(params[:id])
    end

    def destroy
        @organization = Organization.find(params[:id])
        respond_to do |format|
            if @organization.destroy
                format.turbo_stream {render turbo_stream: turbo_stream.remove("organization-#{@organization.id}")}
            end
        end
    end

    private

    def organization_params
        params.require(:organization).permit(:name, :email)
    end

end
