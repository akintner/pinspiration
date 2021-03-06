require "rails_helper"

describe "Board Edit" do
  before do
    @user = create(:registered_user)
    stub_log_in_user(@user)
    @username = @user.pinspiration_credentials.first.username
    category = create(:category)
    @board = create(:board, registered_user: @user, category_id: category.id)
  end

  it "a user can edit a board from the board's show page" do
    visit registered_users_board_path(@username, @board.name)

    click_on('Edit')

    expect(current_path).to eq(registered_users_edit_board_path(@username, @board.name))
  end

  it "a user can edit a board from the board index page" do
    visit registered_users_boards_path(@username)

    click_on('Edit')

    expect(current_path).to eq(registered_users_edit_board_path(@username, @board.name))
  end

  it "a user can edit all fields for the board" do
    visit registered_users_edit_board_path(@username, @board.name)

    within "form" do
      fill_in "board[name]", with: "Bespoke"
      fill_in "board[description]", with: "100% authentic"
      find("option[value='private']").select_option
      find("option[value='1']").select_option
      click_on "Submit"
    end

    expect(current_path).to eq(registered_users_board_path(@username, "Bespoke"))
    expect(page).to have_content("Bespoke")
    expect(page).to have_content("100% authentic")
  end
end
