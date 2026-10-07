defprotocol Noizu.Weaviate.Class.Protocol do
  def id(subject, options)
  def class(subject, options)
  def decoder(subject, options)
end


defimpl Noizu.Weaviate.Class.Protocol, for: Any do
  def id(_subject, _options), do: nil
  def class(_subject, _options), do: nil
  def decoder(_subject, _options), do: :json

  defmacro __deriving__(module, _struct, _options) do
    quote do
      defimpl Noizu.Weaviate.Class.Protocol, for: [unquote(module)] do
        def id(subject, _options) do
          subject.meta.id
        end
        def class(subject, _options) do
          subject.meta.class
        end
        def decoder(subject, _options) do
          subject.__struct__
        end
      end
    end
  end
end

defimpl Noizu.Weaviate.Class.Protocol, for: Noizu.Weaviate.Class do
  def id(subject, _options) do
    subject.meta.id
  end
  def class(subject, _options) do
    subject.meta.class
  end
  def decoder(subject, _options) do
    subject.__struct__
  end
end
