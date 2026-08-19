# frozen_string_literal: true

module Seam
  module Resources
    class DeviceProvider < BaseResource
      # Indicates whether the lock supports configuring automatic locking.
      # @return [Boolean, nil]
      attr_accessor :can_configure_auto_lock
      # Indicates whether the thermostat supports cooling.
      # @return [Boolean, nil]
      attr_accessor :can_hvac_cool
      # Indicates whether the thermostat supports heating.
      # @return [Boolean, nil]
      attr_accessor :can_hvac_heat
      # Indicates whether the thermostat supports simultaneous heating and cooling.
      # @return [Boolean, nil]
      attr_accessor :can_hvac_heat_cool
      # Indicates whether the device supports programming offline access codes.
      # @return [Boolean, nil]
      attr_accessor :can_program_offline_access_codes
      # Indicates whether the device supports programming online access codes.
      # @return [Boolean, nil]
      attr_accessor :can_program_online_access_codes
      # Indicates whether the thermostat supports different climate programs for each day of the week.
      # @return [Boolean, nil]
      attr_accessor :can_program_thermostat_programs_as_different_each_day
      # Indicates whether the thermostat supports a single climate program applied to every day.
      # @return [Boolean, nil]
      attr_accessor :can_program_thermostat_programs_as_same_each_day
      # Indicates whether the thermostat supports weekday/weekend climate programs.
      # @return [Boolean, nil]
      attr_accessor :can_program_thermostat_programs_as_weekday_weekend
      # Indicates whether the device supports remote locking.
      # @return [Boolean, nil]
      attr_accessor :can_remotely_lock
      # Indicates whether the device supports remote unlocking.
      # @return [Boolean, nil]
      attr_accessor :can_remotely_unlock
      # Indicates whether the thermostat supports running climate programs.
      # @return [Boolean, nil]
      attr_accessor :can_run_thermostat_programs
      # Indicates whether the device supports simulating connection in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_connection
      # Indicates whether the device supports simulating disconnection in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_disconnection
      # Indicates whether the hub supports simulating connection in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_hub_connection
      # Indicates whether the hub supports simulating disconnection in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_hub_disconnection
      # Indicates whether the device supports simulating a paid subscription in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_paid_subscription
      # Indicates whether the device supports simulating removal in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_removal
      # Indicates whether the thermostat can be turned off.
      # @return [Boolean, nil]
      attr_accessor :can_turn_off_hvac
      # Indicates whether the lock supports unlocking with an access code.
      # @return [Boolean, nil]
      attr_accessor :can_unlock_with_code
      # Name of the device provider.
      # @return [String]
      # Known values:
      # - `hotek`
      # - `dormakaba_community`
      # - `legic_connect`
      # - `akuvox`
      # - `august`
      # - `avigilon_alta`
      # - `brivo`
      # - `butterflymx`
      # - `schlage`
      # - `smartthings`
      # - `yale`
      # - `genie`
      # - `doorking`
      # - `salto`
      # - `salto_ks`
      # - `salto_ks_accept`
      # - `lockly`
      # - `ttlock`
      # - `linear`
      # - `noiseaware`
      # - `nuki`
      # - `igloo`
      # - `kwikset`
      # - `minut`
      # - `my_2n`
      # - `controlbyweb`
      # - `nest`
      # - `igloohome`
      # - `ecobee`
      # - `four_suites`
      # - `dormakaba_oracode`
      # - `pti`
      # - `wyze`
      # - `seam_passport`
      # - `visionline`
      # - `assa_abloy_credential_service`
      # - `tedee`
      # - `honeywell_resideo`
      # - `first_alert`
      # - `latch`
      # - `akiles`
      # - `assa_abloy_vostio`
      # - `assa_abloy_vostio_credential_service`
      # - `tado`
      # - `salto_space`
      # - `sensi`
      # - `keynest`
      # - `korelock`
      # - `keyincode`
      # - `dormakaba_ambiance`
      # - `ultraloq`
      # - `yacan`
      # - `dusaw`
      # - `sifely`
      # - `thirty_three_lock`
      # - `ring`
      # - `ical`
      # - `lodgify`
      # - `hostaway`
      # - `guesty`
      # - `acuity_scheduling`
      # - `omnitec`
      # - `kisi`
      # - `aqara`
      attr_accessor :device_provider_name
      # Display name for the device provider.
      # @return [String]
      attr_accessor :display_name
      # Image URL for the device provider.
      # @return [String]
      attr_accessor :image_url
      # List of provider categories to which the device provider belongs, such as `stable`, `consumer_smartlocks`, `thermostats`, and so on.
      # @return [Array<String>]
      # Known values:
      # - `stable`
      # - `consumer_smartlocks`
      # - `beta`
      # - `thermostats`
      # - `noise_sensors`
      # - `access_control_systems`
      # - `cameras`
      # - `connectors`
      attr_accessor :provider_categories
    end
  end
end
