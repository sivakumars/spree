# frozen_string_literal: true

require 'spec_helper'

require 'rswag/specs'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('../../docs').to_s # Rails.root is a dummy app

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v2/platform/index.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Platform API V2',
        contact: {
          name: 'Spark Solutions',
          url: 'https://sparksolutions.co',
          email: 'we@sparksolutions.co',
        },
        version: 'v2'
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ],
      tags: [
        { name: 'Addresses' },
        { name: 'Adjustments' },
        { name: 'Classifications' },
        { name: 'Countries' },
        { name: 'CMS Pages' },
        { name: 'CMS Sections' },
        { name: 'Line Items' },
        { name: 'Menu Items' },
        { name: 'Menus' },
        { name: 'Option Types' },
        { name: 'Option Values' },
        { name: 'Orders' },
        { name: 'Shipping Categories' },
        { name: 'Taxons' },
        { name: 'Users' },
        { name: 'Wishlists' },
        { name: 'Wished Items' }
      ],
      components: {
        securitySchemes: {
          bearer_auth: {
            type: :http,
            scheme: :bearer
          }
        },
        schemas: {
          address_params: {
            type: :object,
            properties: {
              country_id: { type: :string, example: '224' },
              state_id: { type: :string, example: '516' },
              state_name: { type: :string, example: 'New York' },
              address1: { type: :string, example: '5th ave' },
              address2: { type: :string, example: '1st suite' },
              city: { type: :string, example: 'NY' },
              zipcode: { type: :string, example: '10001' },
              phone: { type: :string, example: '+1 123 456 789' },
              alternative_phone: { type: :string },
              firstname: { type: :string, example: 'John' },
              lastname: { type: :string, example: 'Snow' },
              label: { type: :string, example: 'My home address' },
              company: { type: :string, example: 'Vendo Cloud Inc' },
              user_id: { type: :string }
            },
            required: %w[country_id address1 city zipcode phone firstname lastname]
          },
          adjustment_params: {
            type: :object,
            properties: {
              order_id: { type: :string },
              lebal: { type: :string, example: 'Shipping costs' },
              adjustable_id: { type: :string },
              adjustable_type: { type: :string, example: 'Spree::LineItem' },
              source_id: { type: :string },
              source_type: { type: :string, example: 'Spree::TaxRate' },
              amount: { type: :number, example: 10.90 },
              mandatory: { type: :boolean },
              eligible: { type: :boolean },
              state: { type: :string, example: 'closed', default: 'open', enum: ['closed', 'open'] },
              included: { type: :boolean, example: true, default: false },
              created_at: { type: :string, example: Time.current },
              updated_at: { type: :string, example: Time.current }
            },
            required: %w[order_id label adjustable_id adjustable_type]
          },
          classification_params: {
            type: :object,
            properties: {
              product_id: { type: :string },
              taxon_id: { type: :string },
              position: { type: :integer }
            }
          },
          line_item_params: {
            type: :object,
            properties: {
              order_id: { type: :string, example: '1' },
              variant_id: { type: :string, example: '1' },
              quantity: { type: :integer, example: 2 },
              price: { type: :number, example: 19.90 },
              cost_price: { type: :number, example: 10.90 },
              adjustment_total: { type: :number },
              additional_tax_total: { type: :number },
              promo_total: { type: :number },
              included_tax_total: { type: :number },
              pre_tax_amount: { type: :number },
              taxable_adjustment_total: { type: :number },
              non_taxable_adjustment_total: { type: :number }
            },
            required: %w[order_id variant_id quantity]
          },
          option_type_params: {
            type: :object,
            properties: {
              name: { type: :string },
              presentation: { type: :string }
            },
            required: %w[name presentation]
          },
          option_value_params: {
            type: :object,
            properties: {
              name: { type: :string },
              presentation: { type: :string },
              option_values_attributes: { type: :string }
            },
            required: %w[name presentation]
          },
          order_params: {
            type: :object,
            properties: {
              number: { type: :string },
              item_total: { type: :number, example: 170.90 },
              total: { type: :number, example: 190.90 },
              state: { type: :string, example: 'complete', enum: %w[cart address delivery payment confirm complete] },
              adjustment_total: { type: :number, example: 20.0 },
              user_id: { type: :string },
              completed_at: { type: :string, format: :date_time, example: Time.current },
              bill_address_id: { type: :string },
              ship_address_id: { type: :string },
              payment_total: { type: :number, example: 190.90 },
              shipment_state: { type: :string, example: 'shipped' },
              payment_state: { type: :string, example: 'paid' },
              email: { type: :string, format: :email, example: 'hi@getvendo.com' },
              special_instructions: { type: :string, example: 'I need it ASAP!' },
              currency: { type: :string, example: 'USD' },
              last_ip_address: { type: :string, example: '127.0.0.1' },
              created_by_id: { type: :string },
              shipment_total: { type: :number, example: 10.0 },
              additional_tax_total: { type: :number, example: 10.0 },
              promo_total: { type: :number, example: 0.0 },
              channel: { type: :string, example: 'online' },
              included_tax_total: { type: :number, example: 0.0 },
              item_count: { type: :integer, example: 2 },
              approver_id: { type: :string },
              approved_at: { type: :string, format: :date_time, example: Time.current },
              confirmation_delivered: { type: :boolean, example: true, default: false },
              considered_risky: { type: :boolean, example: true, default: false },
              canceled_at: { type: :string, format: :date_time },
              canceler_id: { type: :string },
              state_lock_version: { type: :integer, example: 1 },
              taxable_adjustment_total: { type: :number, example: 170.90 },
              non_taxable_adjustment_total: { type: :number, example: 10.0 },
              store_owner_notification_delivered: { type: :boolean, example: true, default: false },
              bill_address_attributes: { '$ref': '#/components/schemas/address_params' },
              ship_address_attributes: { '$ref': '#/components/schemas/address_params' },
              line_items_attributes: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    variant_id: { type: :string, example: '1' },
                    quantity: { type: :integer, example: 2 },
                    price: { type: :number, example: 19.90 }
                  }
                }
              }
            }
          },
          product_params: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :string },
              available_on: { type: :string },
              discontinue_on: { type: :string },
              permalink: { type: :string },
              meta_description: { type: :string },
              meta_keywords: { type: :string },
              price: { type: :string },
              sku: { type: :string },
              deleted_at: { type: :string },
              prototype_id: { type: :string },
              option_values_hash: { type: :string },
              weight: { type: :string },
              height: { type: :string },
              width: { type: :string },
              depth: { type: :string },
              shipping_category_id: { type: :string },
              tax_category_id: { type: :string },
              cost_currency: { type: :string },
              cost_price: { type: :string },
              compare_at_price: { type: :string },
              option_type_ids: { type: :string },
              taxon_ids: { type: :string }
            },
            required: %w[name price shipping_category_id]
          },
          user_params: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string },
              ship_address_id: { type: :string },
              bill_address_id: { type: :string },
            },
            required: %w[email password password_confirmation]
          },
          taxon_params: {
            type: :object,
            properties: {
              taxonomy_id: { type: :string },
              parent_id: { type: :string },
              name: { type: :string }
            },
            required: %w[name taxonomy_id]
          },
          menu_params: {
            type: :object,
            properties: {
              name: { type: :string },
              location: { type: :string },
              locale: { type: :string }
            },
            required: %w[name location locale]
          },
          menu_item_params: {
            type: :object,
            properties: {
              name: { type: :string },
              code: { type: :string },
              subtitle: { type: :string },
              destination: { type: :string },
              menu_id: { type: :string },
              new_window: { type: :boolean },
              item_type: { type: :string },
              linked_resource_type: { type: :string },
              linked_resource_id: { type: :integer }
            },
            required: %w[name menu_id]
          },
          menu_item_reposition_params: {
            type: :object,
            properties: {
              new_parent_id: { type: :integer },
              new_position_idx: { type: :integer }
            },
            required: %w[new_parent_id new_position_idx]
          },
          shipping_category_params: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Another Category' },
              created_at: { type: :string, example: Time.current, default: Time.current },
              updated_at: { type: :string, example: Time.current, default: Time.current },
            },
            required: %w[name]
          },
          wishlist_params: {
            type: :object,
            properties: {
              name: { type: :string },
              user_id: { type: :string },
              is_default: { type: :boolean },
              is_private: { type: :boolean }
            },
            required: %w[name user_id]
          },
          wished_item_params: {
            type: :object,
            properties: {
              wishlist_id: { type: :string },
              variant_id: { type: :string },
              quantity: {
                type: :integer,
                description: 'Must be an integer greater than 0'
              }
            },
            required: %w[wishlist_id variant_id quantity]
          },
          cms_page_params: {
            type: :object,
            properties: {
              title: { type: :string },
              meta_title: { type: :string },
              content: { type: :string, },
              meta_description: { type: :string },
              visible: { type: :string },
              slug: { type: :string },
              locale: { type: :string }
            },
            required: %w[title locale]
          },
          cms_section_params: {
            type: :object,
            properties: {
              name: { type: :string },
              cms_page_id: { type: :string },
              content: { type: :object, },
              settings: { type: :object },
              fit: { type: :string },
              destination: { type: :string },
            },
            required: %w[name cms_page_id]
          },
          cms_section_reposition_params: {
            type: :object,
            properties: {
              new_position_idx: { type: :integer }
            },
            required: %w[new_position_idx]
          },
          amount_param: {
            type: :object,
            properties: {
              amount: { type: :number }
            }
          },
          coupon_code_param: {
            type: :object,
            properties: {
              coupon_code: { type: :string }
            }
          },
          resources_list: {
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  allOf: [
                    { '$ref' => '#/components/schemas/resource_properties' }
                  ]
                }
              },
              meta: {
                type: :object,
                properties: {
                  count: { type: :integer },
                  total_count: { type: :integer },
                  total_pages: { type: :integer }
                },
                required: %w[count total_count total_pages]
              },
              links: {
                type: :object,
                properties: {
                  self: { type: :string },
                  next: { type: :string },
                  prev: { type: :string },
                  last: { type: :string },
                  first: { type: :string }
                },
                required: %w[self next prev last first]
              }
            },
            required: %w[data meta links]
          },
          resource_properties: {
            type: :object,
            properties: {
              id: { type: :string },
              type: { type: :string },
              attributes: { type: :object },
              relationships: { type: :object }
            },
            required: %w[id type attributes]
          },
          resource: {
            type: :object,
            properties: {
              data: { '$ref' => '#/components/schemas/resource_properties' },
            },
            required: %w[data]
          },
          error: {
            type: :object,
            properties: {
              error: { type: :string },
            },
            required: %w[error]
          },
          validation_errors: {
            type: :object,
            properties: {
              error: { type: :string },
              errors: { type: :object }
            },
            required: %w[error errors]
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml

  # auto generate examples based on response
  config.after do |example|
    next if example.metadata[:swagger].nil?
    next if response.nil? || response.body.blank?

    example.metadata[:response][:content] = {
      'application/vnd.api+json' => {
        examples: {
          'Example': {
            value: JSON.parse(response.body, symbolize_names: true)
          }
        }
      }
    }
  end
end
