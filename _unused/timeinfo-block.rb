# ------------------------------------------------------------------------------
# ~/_plugins/asciidoctor-extensions/dailymotion-block.rb
# Asciidoctor extension for J1 Dailymotion Video
#
# Product/Info:
# https://jekyll.one
#
# Copyright (C) 2023, 2024 Juergen Adams
#
# J1 Template is licensed under the MIT License.
# See: https://github.com/jekyll-one-org/j1-template/blob/main/LICENSE
# ------------------------------------------------------------------------------
require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'
include Asciidoctor

# ------------------------------------------------------------------------------
# A block macro that embeds a video from the Dailymotion platform
# into the output document
#
# Usage:
#
#   timeinfo::duration[type="audio|video" role="CSS classes"]
#
# Example:
#
#   timeinfo::45+[type="video" role="mt-5 mb-5"]
#
# ------------------------------------------------------------------------------
# See:
# https://www.tutorialspoint.com/creating-a-responsive-video-player-using-video-js
# ------------------------------------------------------------------------------

Asciidoctor::Extensions.register do

  class TimeInfoBlockMacro < Extensions::BlockMacroProcessor
    use_dsl

    named :timeinfo
    name_positional_attributes 'type' 'duration', 'role'
    default_attrs 'type' => 'video',
                  'duration' => 'Minuten',
                  'role' => 'mt-3 mb-3'

    role = %(#{attributes['type']})

    if role == 'video'
      type_string = 'Videozeit'
    end

    def process parent, target, attributes

      html = %(
        <div class="video-title #{attributes['role']}">
          <i class="mdib mdi-bs-primary mdib-clock mdib-24px mr-2"></i>
          #{target} #{attributes['duration']} #{type_string}
        </div>
      )

      create_pass_block parent, html, attributes, subs: nil
    end
  end

  block_macro TimeInfoBlockMacro
end
