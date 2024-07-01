
include: transactions_base.view
view: bitcoin_transactions {
  extends: [transactions_base]
  label: "Bitcoin Transactions"
  sql_table_name: `bigquery-public-data.crypto_bitcoin.transactions` ;;

#   dimension: block_hash {
#     type: string
#     description: "Hash of the block which contains this transaction"
#     sql: ${TABLE}.block_hash ;;
#   }
#   dimension: block_number {
#     type: number
#     description: "Number of the block which contains this transaction"
#     sql: ${TABLE}.block_number ;;
#   }
#   dimension_group: block_timestamp {
#     type: time
#     description: "Timestamp of the block which contains this transaction"
#     timeframes: [raw, time, date, week, month, quarter, year]
#     sql: ${TABLE}.block_timestamp ;;
#   }
#   dimension: fee {
#     type: number
#     description: "The fee paid by this transaction"
#     sql: ${TABLE}.fee ;;
#   }
#   measure: avg_fee {
#     type: average
#     label: "Average Fee"
#     description: "Average fee"
#     sql: ${fee} ;;
#   }
#   measure: total_fee {
#     type: sum
#     label: "Total Fee"
#     description: "Total Fees"
#     sql:${fee}  ;;
#   }
#   dimension: hash {
#     primary_key: yes
#     type: string
#     description: "The hash of this transaction"
#     sql: ${TABLE}.`hash` ;;
#   }
#   dimension: input_count {
#     type: number
#     description: "The number of inputs in the transaction"
#     sql: ${TABLE}.input_count ;;
#   }
#   dimension: input_value {
#     type: number
#     description: "Total value of inputs in the transaction"
#     sql: ${TABLE}.input_value ;;
#   }
#   measure: avg_input_value {
#     type: average
#     label: "Average Input Value"
#     description: "Average Input Value"
#     sql: ${input_value} ;;
#   }
#   dimension: inputs {
#     hidden: yes
#     sql: ${TABLE}.inputs ;;
#   }
#   #commenting out dimensions I'm not sure I'll use to remove clutter
#   # dimension: is_coinbase {
#   #   type: yesno
#   #   description: "true if this transaction is a coinbase transaction"
#   #   sql: ${TABLE}.is_coinbase ;;
#   # }
#   # dimension: lock_time {
#   #   type: number
#   #   description: "Earliest time that miners can include the transaction in their hashing of the Merkle root to attach it in the latest block of the blockchain"
#   #   sql: ${TABLE}.lock_time ;;
#   # }
#   dimension: output_count {
#     type: number
#     description: "The number of outputs in the transaction"
#     sql: ${TABLE}.output_count ;;
#   }
#   dimension: output_value {
#     type: number
#     description: "Total value of outputs in the transaction"
#     sql: ${TABLE}.output_value ;;
#   }
#   measure: avg_output_value {
#     type: average
#     label: "Average Output Value"
#     description: "Average output value"
#     sql: ${output_value} ;;
#   }
#   dimension: outputs {
#     hidden: yes
#     sql: ${TABLE}.outputs ;;
#   }
#   dimension: size {
#     type: number
#     description: "The size of this transaction in bytes"
#     sql: ${TABLE}.size ;;
#   }
#   # dimension: version {
#   #   type: number
#   #   description: "Protocol version specified in block which contained this transaction"
#   #   sql: ${TABLE}.version ;;
#   # }
#   dimension: virtual_size {
#     type: number
#     description: "The virtual transaction size (differs from size for witness transactions)"
#     sql: ${TABLE}.virtual_size ;;
#   }
#   measure: count {
#     type: count
#     drill_fields: [block_hash, block_number, size, virtual_size, hash, output_count, output_value, input_count, input_value, fee]
#   }
}
#--------------------------------------------------------------------------------------------------------------------------------------------------------------
view: bitcoin_inputs {

  dimension: addresses {
    hidden: yes
    sql: ${TABLE}.addresses ;;
  }
  dimension: index {
    type: number
    description: "0-indexed number of an input within a transaction"
    sql: ${TABLE}.index ;;
  }
  #commenting out fields I don't think I'll need in order to de-clutter
  # dimension: required_signatures {
  #   type: number
  #   description: "The number of signatures required to authorize the spent output"
  #   sql: ${TABLE}.required_signatures ;;
  # }
  # dimension: script_asm {
  #   type: string
  #   description: "Symbolic representation of the bitcoin's script language op-codes"
  #   sql: ${TABLE}.script_asm ;;
  # }
  # dimension: script_hex {
  #   type: string
  #   description: "Hexadecimal representation of the bitcoin's script language op-codes"
  #   sql: ${TABLE}.script_hex ;;
  # }
  dimension: sequence {
    type: number
    description: "A number intended to allow unconfirmed time-locked transactions to be updated before being finalized; not currently used except to disable locktime in a transaction"
    sql: sequence ;;
  }
  dimension: spent_output_index {
    type: number
    description: "The index of the output this input spends"
    sql: spent_output_index ;;
  }
  dimension: spent_transaction_hash {
    type: string
    description: "The hash of the transaction which contains the output that this input spends"
    sql: spent_transaction_hash ;;
  }
  dimension: transactions__bigquerypublicdata_crypto_bitcoin_inputs {
    type: string
    description: "Transaction inputs"
    hidden: yes
    sql: transactions__bigquerypublicdata_crypto_bitcoin_inputs ;;
  }
  dimension: type {
    type: string
    description: "The address type of the spent output"
    sql: ${TABLE}.type ;;
  }
  dimension: value {
    type: number
    description: "The value in base currency attached to the spent output"
    sql: ${TABLE}.value ;;
  }
}
#---------------------------------------------------------------------------------------------------------------------------------------------------------------
view: bitcoin_outputs {

  dimension: addresses {
    hidden: yes
    sql: ${TABLE}.addresses ;;
  }
  dimension: index {
    type: number
    description: "0-indexed number of an output within a transaction used by a later transaction to refer to that specific output"
    sql: ${TABLE}.index ;;
  }
  #commenting out fields I don't think I'll need
  # dimension: required_signatures {
  #   type: number
  #   description: "The number of signatures required to authorize spending of this output"
  #   sql: ${TABLE}.required_signatures ;;
  # }
  # dimension: script_asm {
  #   type: string
  #   description: "Symbolic representation of the bitcoin's script language op-codes"
  #   sql: ${TABLE}.script_asm ;;
  # }
  # dimension: script_hex {
  #   type: string
  #   description: "Hexadecimal representation of the bitcoin's script language op-codes"
  #   sql: ${TABLE}.script_hex ;;
  # }
  dimension: transactions__bigquerypublicdata_crypto_bitcoin_outputs {
    type: string
    description: "Transaction outputs"
    hidden: yes
    sql: transactions__bigquerypublicdata_crypto_bitcoin_outputs ;;
  }
  dimension: type {
    type: string
    description: "The address type of the output"
    sql: ${TABLE}.type ;;
  }
  dimension: value {
    type: number
    description: "The value in base currency attached to this output"
    sql: ${TABLE}.value ;;
  }
}
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
view: bitcoin_inputs_addresses {

  dimension: transactions__inputs__addresses {
    type: string
    description: "Addresses which own the spent output"
    sql: transactions__inputs__addresses ;;
  }
}
#------------------------------------------------------------------------------------------------------------------------------------------------------------------
view: bitcoin_outputs_addresses {

  dimension: transactions__outputs__addresses {
    type: string
    description: "Addresses which own this output"
    sql: transactions__outputs__addresses ;;
  }
}
