connection: "looker-private-demo"

# include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
#creating a test explore with one view for now
explore: bitcoin_blocks {
  label: "Coin Data"
  join: bitcoin_transactions {
    relationship: one_to_many
    sql_on: ${bitcoin_blocks.hash} = ${bitcoin_transactions.block_hash} ;;
  }
  join: bitcoin_inputs {
      view_label: "Bitcoin: Inputs"
      sql: LEFT JOIN UNNEST(${bitcoin_transactions.inputs}) as bitcoin_inputs ;;
      relationship: one_to_many
  }
  join: bitcoin_outputs {
      view_label: "Bitcoin: Outputs"
      sql: LEFT JOIN UNNEST(${bitcoin_transactions.outputs}) as bitcoin_outputs ;;
      relationship: one_to_many
  }
  join: bitcoin_inputs_addresses {
      view_label: "Transactions: Inputs Addresses"
      sql: LEFT JOIN UNNEST(${bitcoin_inputs.addresses}) as bitcoin_inputs_addresses ;;
      relationship: one_to_many
  }
  join: bitcoin_outputs_addresses {
      view_label: "Transactions: Outputs Addresses"
      sql: LEFT JOIN UNNEST(${bitcoin_outputs.addresses}) as bitcoin_outputs_addresses ;;
      relationship: one_to_many
  }
}
explore: market_data {
  label: "Market Data"
  # join: history {
  #   relationship: one_to_many
  #   sql_on: ${market_data.id} = ${history.id} ;;
  # }
  }

  explore: history {
    label: "History Data"
  join: history__prices__amount {
    view_label: "History: Prices Amount"
    sql: CROSS JOIN UNNEST(${history.prices__amount}) as history__prices__amount WITH OFFSET as history__prices__amount_offset ;;
    relationship: one_to_many
  }
  join: history__prices__epoch_time {
    view_label: "History: Prices Epoch Time"
    sql: CROSS JOIN UNNEST(${history.prices__epoch_time}) as history__prices__epoch_time WITH OFFSET as history__prices__epoch_time_offset ;;
    relationship: one_to_many
  }
  # join: history__market_caps__amount {
  #   view_label: "History: Market Caps Amount"
  #   sql: LEFT JOIN UNNEST(${history.market_caps__amount}) as history__market_caps__amount ;;
  #   relationship: one_to_many
  # }
  # join: history__total_volumes__amount {
  #   view_label: "History: Total Volumes Amount"
  #   sql: LEFT JOIN UNNEST(${history.total_volumes__amount}) as history__total_volumes__amount ;;
  #   relationship: one_to_many
  # }
  # join: history__market_caps__epoch_time {
  #   view_label: "History: Market Caps Epoch Time"
  #   sql: LEFT JOIN UNNEST(${history.market_caps__epoch_time}) as history__market_caps__epoch_time ;;
  #   relationship: one_to_many
  # }
  # join: history__total_volumes__epoch_time {
  #   view_label: "History: Total Volumes Epoch Time"
  #   sql: LEFT JOIN UNNEST(${history.total_volumes__epoch_time}) as history__total_volumes__epoch_time ;;
  #   relationship: one_to_many
  # }

  # join: history_pdt {
  #   view_label: "History"
  #   relationship: one_to_many
  #   sql_on: ${market_data.id}=${history_pdt.id} ;;
  #   }

  }
