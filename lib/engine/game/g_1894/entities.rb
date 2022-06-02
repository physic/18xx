# frozen_string_literal: true

module Engine
  module Game
    module G1894
      module Entities
        COMPANIES = [
          {
            name: 'Ligne Longwy-Villerupt-Micheville',
            sym: 'LVM',
            value: 20,
            revenue: 5,
            desc: 'Owning corporation may lay a yellow tile in I14.'\
                  ' This is in addition to the corporation\'s tile builds.'\
                  ' No connection required. Blocks I14 while owned by a player.',
            abilities: [{ type: 'blocks_hexes', owner_type: 'player', hexes: ['I14'] },
                        {
                          type: 'tile_lay',
                          owner_type: 'corporation',
                          hexes: ['I14'],
                          tiles: %w[7 8 9],
                          when: 'owning_corp_or_turn',
                          count: 1,
                        }],
          },
          {
            name: 'Charleroi-Sud',
            sym: 'CS',
            value: 50,
            revenue: 10,
            desc: 'Owning corporation may lay a yellow tile or upgrade a yellow tile in Charleroi'\
                  ' (G14) along with an optional station marker.'\
                  ' This counts as one of the corporation\'s tile builds.'\
                  ' Blocks G14 while owned by a player.',
            abilities: [{ type: 'blocks_hexes', owner_type: 'player', hexes: ['G14'] },
                        {
                          type: 'teleport',
                          owner_type: 'corporation',
                          hexes: ['G14'],
                          tiles: %w[14 15 57 619],
                        }],
          },
          {
            name: 'Ligne de Saint-Quentin à Guise',
            sym: 'SQG',
            value: 90,
            desc: 'Revenue is equal to twice the revenue of Saint-Quentin (G10) if Saint-Quentin is green or brown, otherwise it\'s 0 F.'\
                  ' Closes in purple                            phase.',
            abilities: [{ type: 'close', on_phase: 'Purple' },],
          },
          {
            name: 'London shipping',
            sym: 'PC',
            value: 100,
            revenue: 15,
            desc: 'Owning corporation may place a +10 marker in London (A10). For this corporation only, the value'\
                  ' of London is increased by 10.',
            abilities: [{
              type: 'assign_hexes',
              when: 'owning_corp_or_turn',
              hexes: ['A10'],
              count: 1,
              owner_type: 'corporation',
            },
                        {
                          type: 'assign_corporation',
                          when: 'sold',
                          count: 1,
                          owner_type: 'corporation',
                        }],
          },
          {
            name: 'CAB minor shareholding',
            sym: 'CABMS',
            value: 140,
            revenue: 20,
            desc: 'Owning player immediately receives a 10% share of the CAB without further payment.',
            abilities: [{ type: 'shares', shares: 'CAB_1' }],
          },
          {
            name: 'PLM major shareholding',
            sym: 'PLMMS',
            value: 200,
            revenue: 25,
            desc: 'Owning player immediately receives the President\'s certificate of the'\
                  ' PLM without further payment. This private company may not be sold to any corporation, and does'\
                  ' not exchange hands if the owning player loses the Presidency of the PLM.'\
                  ' Closes in green phase.',
            abilities: [{ type: 'close', on_phase: 'Green' },
                        { type: 'no_buy' },
                        { type: 'shares', shares: 'PLM_0' }],
          },
        ].freeze

        CORPORATIONS = [
          {
            sym: 'Ouest',
            name: 'Chemins de fer de l\'Ouest',
            logo: '1894/Ouest',
            simple_logo: '1894/Ouest.alt',
            tokens: [0, 40, 60, 80, 100],
            max_ownership_percent: 70,
            coordinates: 'D3',
            color: '#4682b4',
          },
          {
            sym: 'Nord',
            name: 'Chemins de fer du Nord',
            logo: '1894/Nord',
            simple_logo: '1894/Nord.alt',
            tokens: [0, 40, 60, 80, 100],
            max_ownership_percent: 70,
            coordinates: 'D11',
            color: '#ff4040',
          },
          {
            sym: 'GR',
            name: 'Gent Railway',
            logo: '1894/GR',
            simple_logo: '1894/GR.alt',
            tokens: [0, 40, 60, 80, 100],
            max_ownership_percent: 70,
            coordinates: 'D15',
            color: '#fcf75e',
            text_color: 'black',
          },
          {
            sym: 'CAB',
            name: 'Chemins de fer d\'Amiens à Boulogne',
            logo: '1894/CAB',
            simple_logo: '1894/CAB.alt',
            tokens: [0, 40, 60, 80, 100],
            max_ownership_percent: 70,
            coordinates: 'E6',
            color: '#9c661f',
          },
          {
            sym: 'Belge',
            name: 'Chemins de fer de l\'État belge',
            logo: '1894/Belge',
            simple_logo: '1894/Belge.alt',
            tokens: [0, 40, 60, 80],
            max_ownership_percent: 70,
            coordinates: 'F15',
            color: '#61b229',
          },
          {
            sym: 'PLM',
            name: 'Chemins de fer de Paris à Lyon et à la Méditerranée',
            logo: '1894/PLM',
            simple_logo: '1894/PLM.alt',
            tokens: [0, 40, 60, 80],
            max_ownership_percent: 70,
            coordinates: 'G4',
            city: 0,
            color: '#dda0dd',
            text_color: 'black',
          },
          {
            sym: 'Est',
            name: 'Chemins de fer de l\'Est',
            logo: '1894/Est',
            simple_logo: '1894/Est.alt',
            tokens: [0, 40, 60, 80, 100],
            max_ownership_percent: 70,
            coordinates: 'I8',
            color: '#ff9966',
            text_color: 'black',
            abilities: [
              {
                type: 'hex_bonus',
                amount: 0,
                description: 'Value of Le Sud (I2) increased by 30.',
                hexes: ['I2'],
              },
            ],
          },
          {
            sym: 'F1',
            name: 'French 1',
            logo: '1894/F1',
            simple_logo: '1894/F1.alt',
            tokens: [0, 40],
            max_ownership_percent: 70,
            color: '#ffc0cb',
            text_color: 'black',
            abilities: [
              {
                type: 'description',
                description: 'Home in an empty hex in France',
              },
            ],
          },
          {
            sym: 'F2',
            name: 'French 2',
            logo: '1894/F2',
            simple_logo: '1894/F2.alt',
            tokens: [0, 40],
            max_ownership_percent: 70,
            color: 'lime',
            text_color: 'black',
            abilities: [
              {
                type: 'description',
                description: 'Home in an empty hex in France',
              },
            ],
          },
          {
            sym: 'B1',
            name: 'Belgian 1',
            logo: '1894/B1',
            simple_logo: '1894/B1.alt',
            tokens: [0, 40],
            max_ownership_percent: 70,
            color: '#c9c9c9',
            text_color: 'black',
            abilities: [
              {
                type: 'description',
                description: 'Home in an empty hex in Belgium',
              },
            ],
          },
          {
            sym: 'B2',
            name: 'Belgian 2',
            logo: '1894/B2',
            simple_logo: '1894/B2.alt',
            tokens: [0, 40],
            max_ownership_percent: 70,
            color: '#ffefdb',
            text_color: 'black',
            abilities: [
              {
                type: 'description',
                description: 'Home in an empty hex in Belgium',
              },
            ],
          },
        ].freeze
      end
    end
  end
end
