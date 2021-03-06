# encoding: utf-8
require 'spec_helper'
require_relative '../../../app/helpers/modal_helper'

include ActionView::Helpers
include ActionView::Context
include ModalHelper

describe ModalHelper, :type => :helper do
  header_with_close    = { :show_close => true, :dismiss => 'modal', :title => 'Modal header' }
  header_without_close = { :show_close => false, :title => 'Modal header' }
  options              = { :id => "modal",
												 	 :header => header_with_close,
                           :body   => 'This is the body',
                           :footer => content_tag(:button, 'Save', :class => 'btn')
  }

  it 'returns a complete modal' do
    modal_dialog(options).gsub(/\n/, "").should eql BASIC_MODAL.gsub(/\n/, "")
  end

  it 'returns a modal header with a close button if show_close is true' do
    modal_header(header_with_close).gsub(/\n/, "").should eql MODAL_HEADER_WITH_CLOSE.gsub(/\n/, "")
  end

  it 'renders a modal header without a close button' do
      modal_header(header_without_close).gsub(/\n/, "").should eql MODAL_HEADER_WITHOUT_CLOSE.gsub(/\n/, "")
  end

	it 'renders a close button' do
		close_button('modal').should eql "<button class=\"close\" data-dismiss=\"modal\">&times;</button>"
	end

  it 'renders a modal toggle button' do
		modal_toggle('Save', :href => "#modal").gsub(/\n/, "").should eql MODAL_TOGGLE.gsub(/\n/, "")
  end

	it 'renders a cancel button' do
		modal_cancel_button("Cancel", :href => "#modal", :data => {:dismiss => 'modal'}).gsub(/\n/, "").should eql MODAL_CANCEL_BUTTON.gsub(/\n/, "")
	end

end
BASIC_MODAL = <<-HTML
<div class=\"bootstrap-modal modal hide fade\" id="modal"><div class=\"modal-header\"><button class=\"close\" data-dismiss=\"modal\">&times;</button><h3>Modal header</h3></div><div class=\"modal-body\">This is the body</div><div class=\"modal-footer\"><button class=\"btn\">Save</button></div></div>
HTML

MODAL_HEADER_WITHOUT_CLOSE = <<-HTML
<div class="modal-header"><h3>Modal header</h3></div>
HTML

MODAL_HEADER_WITH_CLOSE = <<-HTML
<div class="modal-header"><button class="close" data-dismiss="modal">&times;</button><h3>Modal header</h3></div>
HTML

MODAL_TOGGLE = <<-HTML
<a class="btn" data-toggle="modal" href="#modal">Save</a>
HTML

MODAL_CANCEL_BUTTON = <<-HTML
<a class="btn bootstrap-modal-cancel-button" data-dismiss="modal" href="#modal">Cancel</a>
HTML

