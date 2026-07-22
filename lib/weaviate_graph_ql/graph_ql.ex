defmodule Noizu.Weaviate.GraphQL do
  # ⟦𓆽𓄅𓇛𓀗⟧ encode_value :: auto-generated pointer for public function encode_value
  def encode_value(v) when is_atom(v) and v not in [nil, true, false], do: "#{v}"
  def encode_value(v), do: inspect(v)
  # ⟦𓍚𓀎𓈾𓏌⟧ get :: auto-generated pointer for public function get
  def get(class) do
    %Noizu.Weaviate.GraphQL.Get{class: class}
  end

  # ⟦𓏷𓐥𓈌𓎄⟧ aggregate :: auto-generated pointer for public function aggregate
  def aggregate(class) do
    %Noizu.Weaviate.GraphQL.Aggregate{class: class}
  end

  # ⟦𓊋𓎍𓊁𓍚⟧ explore :: auto-generated pointer for public function explore
  def explore() do
    %Noizu.Weaviate.GraphQL.Explore{}
  end

  # ⟦𓅼𓄮𓁉𓇔⟧ tenant :: auto-generated pointer for public function tenant
  def tenant(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.tenant(container, value)
  end
  def tenant(%Noizu.Weaviate.GraphQL.Aggregate{} = container, value) do
    Noizu.Weaviate.GraphQL.Aggregate.tenant(container, value)
  end

  # ⟦𓌎𓌈𓇗𓆉⟧ additional :: auto-generated pointer for public function additional
  def additional(%Noizu.Weaviate.GraphQL.Get{} = container, properties) do
    value = Noizu.Weaviate.GraphQL.Additional.additional(properties)
    Noizu.Weaviate.GraphQL.Get.additional(container, value)
  end

  # ⟦𓋧𓀃𓏐𓃌⟧ consistency_level :: auto-generated pointer for public function consistency_level
  def consistency_level(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.consistency_level(container, value)
  end

  # ⟦𓐨𓃚𓉑𓈒⟧ search_operator :: auto-generated pointer for public function search_operator
  def search_operator(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.search_operator(container, value)
  end

  # ⟦𓋐𓍔𓉀𓏓⟧ group_by :: auto-generated pointer for public function group_by
  def group_by(%Noizu.Weaviate.GraphQL.Get{} = container, path, groups, objects_per_group) do
    Noizu.Weaviate.GraphQL.GroupBy.group_by(container, path, groups, objects_per_group)
  end

  # ⟦𓇼𓊭𓌸𓈀⟧ limit :: auto-generated pointer for public function limit
  def limit(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.limit(container, value)
  end

  # ⟦𓐫𓉧𓈴𓂆⟧ offset :: auto-generated pointer for public function offset
  def offset(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.offset(container, value)
  end

  # ⟦𓎪𓇁𓉸𓏔⟧ after_call :: auto-generated pointer for public function after_call
  def after_call(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.after_call(container, value)
  end

  # ⟦𓅨𓁴𓀢𓃽⟧ autocut :: auto-generated pointer for public function autocut
  def autocut(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.autocut(container, value)
  end

  # ⟦𓉃𓉵𓄯𓁦⟧ sort :: auto-generated pointer for public function sort
  def sort(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.sort(container, value)
  end

  # ⟦𓍪𓋭𓍁𓁛⟧ property :: auto-generated pointer for public function property
  def property(%Noizu.Weaviate.GraphQL.Get{} = get, property) do
    Noizu.Weaviate.GraphQL.Get.property(get, property)
  end

  # ⟦𓅷𓎤𓉸𓂵⟧ properties :: auto-generated pointer for public function properties
  def properties(%Noizu.Weaviate.GraphQL.Get{} = get, property) do
    Noizu.Weaviate.GraphQL.Get.properties(get, property)
  end

  # ⟦𓁆𓈝𓃺𓇎⟧ where :: auto-generated pointer for public function where
  def where(container, clause), do: Noizu.Weaviate.GraphQL.Where.where(container, clause)

end
