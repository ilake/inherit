require 'asset_fingerprint/asset_tag_helper'
AssetFingerprint.symlink_on_the_fly = false
#if Rails.env == 'development'
#  AssetFingerprint.fingerprinter = :timestamp # default is :md5 
  #  如果用default 的file_name, tinymce 會有問題
  AssetFingerprint.path_rewriter = :query_string # default is :file_name
#end
