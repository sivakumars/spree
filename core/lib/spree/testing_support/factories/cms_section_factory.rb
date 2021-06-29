FactoryBot.define do
  factory :cms_section, class: Spree::CmsSection do
    name { generate(:random_string) }

    factory :cms_hero_section do
      type { 'Spree::Cms::Sections::HeroImage' }
    end

    factory :cms_featured_article_section do
      type { 'Spree::Cms::Sections::FeaturedArticle' }
    end

    factory :cms_product_carousel_section do
      type { 'Spree::Cms::Sections::ProductCarousel' }
    end

    factory :cms_three_taxon_categories_section do
      type { 'Spree::Cms::Sections::ImageGallery' }
    end

    factory :cms_side_by_side_promotion_section do
      type { 'Spree::Cms::Sections::SideBySideImages' }
    end
  end
end
