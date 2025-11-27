# frozen_string_literal: true

class Table::Component < ApplicationViewComponent
  renders_many :columns, TableColumn::Component
  renders_many :table_rows, TableRow::Component
end
