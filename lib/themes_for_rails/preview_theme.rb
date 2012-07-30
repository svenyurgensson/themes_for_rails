# -*- encoding : utf-8 -*-

module ThemesForRails
  module PreviewTheme

    def preview_for_theme_controller_action(theme, kontroller=controller.controller_name, aktion=controller.action_name)
      small = File.join 'theme', kontroller, aktion, "small.png"
      return nil unless preview_exists?(theme, small)
      full = File.join 'theme', kontroller, aktion, "full.png"
      Struct.new(:small, :full).new(theme_image_path(small, theme), theme_image_path(full, theme))
    end

    def preview_for_controller_action(kontroller=controller.controller_name, aktion=controller.action_name)
      small = File.join 'theme', kontroller, aktion, "small.png"
      return nil unless preview_exists?(get_theme, small)
      full = File.join 'theme', kontroller, aktion, "full.png"
      Struct.new(:small, :full).new(theme_image_path(small, get_theme), theme_image_path(full, get_theme))
    end

    def preview_for_theme_layout(theme, layout = current_layout)
      small = File.join 'theme', layout, "small.png"
      return nil unless preview_exists?(theme, small)
      full = File.join 'theme', layout, "full.png"
      Struct.new(:small, :full).new(theme_image_path(small, theme), theme_image_path(full, theme))
    end

    def preview_for_layout(layout = current_layout)
      small = File.join 'theme', layout, "small.png"
      return nil unless preview_exists?(get_theme, small)
      full = File.join 'theme', layout, "full.png"
      Struct.new(:small, :full).new(theme_image_path(small, get_theme), theme_image_path(full, get_theme))
    end

    def current_layout
      layout = controller.send(:_layout) # Rails 3 specific
      if layout.instance_of? String
        layout
      else
        File.basename(layout.identifier).split('.').first
      end
    end

    def preview_exists? theme, url
      File.exist?(File.join(Rails.root, 'app/assets/themes', theme, 'images', url))
    end

    private
    def get_theme
      theme_name || ThemesForRails.config.default_theme
    end

  end
end
