require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do

  describe "GET #index" do

    let(:table) { Table.create(number: 2, num_of_seats: 4) }

    it "responds with status code 200" do
      get :index
      expect(response).to have_http_status 200
    end

    it "assigns the all reservations as @reservations" do
      reservation = Reservation.create!(name: "Test", table: table, num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 1)
      get :index
      expect(assigns(:reservations)).to eq([reservation])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end


  describe "POST #create" do

    context "when valid params are passed" do

      it "responds with status code 302" do
        post :create, { reservation: { name: "test", num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 1 } }
        expect(response).to have_http_status 302
      end

      it "creates a new reservation in the database" do
        Table.create(number: 2, num_of_seats: 4)
        expect { post :create, { reservation: { name: "test", num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 1 } } }.to change {Reservation.all.count}.by(1)
      end

      it "redirects to index page" do
        Table.create(number:2, num_of_seats: 4)
        post :create, { reservation: { name: "test", num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 1 } }
        expect(response).to redirect_to(root_path)
      end

      it "flashes a success message when seats are available" do
        Table.create(number:2, num_of_seats: 4)
        post :create, { reservation: { name: "test", num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 1 } }
        expect(flash.now[:notice]).to eq("Reservation has successfully been created")
      end

      it "flashes an over capacity message when seats are not available" do
        Table.create(number:2, num_of_seats: 4)
        post :create, { reservation: { name: "test", num_of_seats_reserved: 5, reservation_date: Date.new(2017,9,10), hour: 1 } }
        expect(flash.now[:alert]).to eq("Reservation Failed: Seating Capacity Exceeded")
      end

    end


  end

end
