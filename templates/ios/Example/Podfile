use_frameworks!

target '${POD_NAME}_Example' do
  pod '${POD_NAME}', :path => '../'

  target '${POD_NAME}_Tests' do
    inherit! :search_paths

    ${INCLUDED_PODS}
  end
end
