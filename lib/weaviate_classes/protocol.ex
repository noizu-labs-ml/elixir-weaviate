defprotocol Noizu.Weaviate.Class.Protocol do
  # ⟦𓀆𓍋𓅋𓋭⟧ id :: auto-generated pointer for public function id
  def id(subject, options \\ nil)
  # ⟦𓄝𓃹𓅏𓉓⟧ class :: auto-generated pointer for public function class
  def class(subject, options \\ nil)
  # ⟦𓊜𓂩𓃗𓈟⟧ decoder :: auto-generated pointer for public function decoder
  def decoder(subject, options \\ nil)
end


defimpl Noizu.Weaviate.Class.Protocol, for: Any do
  def id(subject, options \\ nil), do: nil
  def class(subject, options \\ nil), do: nil
  def decoder(subject, options \\ nil), do: :json

  # ⟦𓃓𓏈𓆻𓎚⟧ __deriving__ :: auto-generated pointer for public function __deriving__
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
