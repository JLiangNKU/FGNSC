function [ result, num_faces ] = load_faces( subject )

    listing = dir(['data/CroppedYale/yale' subject '/yale*.pgm']);
    filenames = {listing.name};
    num_faces = size(filenames,2);
    result = zeros(48*42, num_faces);

    for i=1:num_faces
        im = imread(['data/CroppedYale/yale' subject '/' filenames{i}]);
        im = imresize(im, [48 42]);
        result(:,i) = reshape(im,48*42,1);
    end

end