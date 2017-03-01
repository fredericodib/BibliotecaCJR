class ImageUploader < CarrierWave::Uploader::Base
  # Adiciona o MiniMagick para permitir o redimensionamento das imagens
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave
 
  #storage :file
 
  # Local onde será guardado as imagens
  #def store_dir
  #  "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "produto-sem-imagem.gif"].compact.join('_'))
  end
 
  ## Tamanhos que o CarrierWave vai salvar as imagens

  # Thumb
  version :thumb do
     process resize_to_fit: [50, 50]
  end
 
  # Medium
  version :medium do
     process resize_to_fit: [150, 150]
  end
  
  # Big
  version :big do
     process resize_to_fit: [1500, 1500]
  end
 
  # Tipos de extensão aceitas
  def extension_whitelist
     %w(jpg jpeg gif png)
  end
end
