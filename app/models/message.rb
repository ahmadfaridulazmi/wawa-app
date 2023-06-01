class Message < ApplicationRecord

  validates_presence_of %i(title phone)
  validates_format_of :phone, 
    with: /(^\+?6?01)([0-46-9]-*[0-9]{7,8}$)/, message: "Invalid format"

  before_create :build_reference

  before_save :sanitize_phone
  before_save :build_whatsapp_link

  def full_whatsapp_url
    return whatsapp_link if messages.blank?

    url_encoded_string = CGI.escape(messages)
    whatsapp_link + '?text=' + url_encoded_string
  end

  private

  def sanitize_phone
    code, number = phone.match(/(^\+?6?01)([0-46-9]-*[0-9]{7,8}$)/).captures
    self.phone = "#{code.gsub(/\+?6|\+/, '')}#{number}"
  end

  def build_whatsapp_link
    self.whatsapp_link = "https://wa.me/#{phone}"
  end

  def build_reference
    self.reference = SecureRandom.hex(6) 
  end
end
