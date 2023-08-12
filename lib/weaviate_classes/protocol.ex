defprotocol Noizu.Weaviate.Class.Protocol do
  def id(subject, options \\ nil)
  def class(subject, options \\ nil)
  def decoder(subject, options \\ nil)
end


defimpl Noizu.Weaviate.Class.Protocol, for: Any do
  def id(subject, options \\ nil), do: nil
  def class(subject, options \\ nil), do: nil
  def decoder(subject, options \\ nil), do: :json

  defmacro __deriving__(module, struct, options) do
    quote do
      defimpl Noizu.Weaviate.Class.Protocol, for: [unquote(module)] do
        def id(subject, options \\ nil) do
          subject.meta.id
        end
        def class(subject, options \\ nil) do
          subject.meta.class
        end
        def decoder(subject, options \\ nil) do
          subject.__struct__
        end
      end
    end
  end
end

defimpl Noizu.Weaviate.Class.Protocol, for: Noizu.Weaviate.Class do
  def id(subject, options \\ nil) do
    subject.meta.id
  end
  def class(subject, options \\ nil) do
    subject.meta.class
  end
  def decoder(subject, options \\ nil) do
    subject.__struct__
  end
end
