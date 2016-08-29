Suzy::Queue.plugin :association_dependencies, messages: :destroy
Suzy::Message.plugin :association_dependencies, headers: :destroy
