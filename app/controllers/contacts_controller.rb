class ContactsController < ApplicationController
  
  def show
    @contact_detail = current_user.contacts
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # POST /contacts or /contacts.json
  def create
    @contact = current_user.contacts.build(contact_params)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to contact_url(@contact), notice: "Your response sent successfully." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :contact_no, :message )
  end

end 