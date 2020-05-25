function [dopasowane_punkty_na_zdjeciu_wczytanym, dopasowane_punkty_na_zdjeciu_bazowym, banknot] = sprawdzanie_banknotu(img_location)
    %% Wczytanie zdjêæ bazowych
    
    global ref_img_10_front;
     ref_img_10_front = imread('D:\PWR\Obrazki\Projekt\Banknoty\10zlfoto\10_base_front.jpg');
    global ref_img_10_back;
    ref_img_10_back = imread('D:\PWR\Obrazki\Projekt\Banknoty\10zlfoto\10_base_back.jpg');
    global ref_img_20_front;
    ref_img_20_front = imread('D:\PWR\Obrazki\Projekt\Banknoty\20z³foto\20_base_front.jpg');
    global ref_img_20_back;
    ref_img_20_back = imread('D:\PWR\Obrazki\Projekt\Banknoty\20z³foto\20_base_back.jpg');
    global ref_img_50_front
    ref_img_50_front = imread('D:\PWR\Obrazki\Projekt\Banknoty\50z³foto\50_base_front.jpg');
    global ref_img_50_back;
    ref_img_50_back = imread('D:\PWR\Obrazki\Projekt\Banknoty\50z³foto\50_base_back.jpg');
    global ref_img_100_front;
    ref_img_100_front = imread('D:\PWR\Obrazki\Projekt\Banknoty\100z³foto\100_base_front.jpg');
    global ref_img_100_back;
    ref_img_100_back = imread('D:\PWR\Obrazki\Projekt\Banknoty\100z³foto\100_base_back.jpg');
    global ref_img_200_front;
    ref_img_200_front = imread('D:\PWR\Obrazki\Projekt\Banknoty\200z³foto\200_base_front.jpg');
    global ref_img_200_back;
    ref_img_200_back = imread('D:\PWR\Obrazki\Projekt\Banknoty\200z³foto\200_base_back.jpg');

    global ref_images;
    ref_images = {ref_img_10_front,ref_img_20_front,ref_img_50_front,ref_img_100_front,ref_img_200_front,ref_img_10_back,ref_img_20_back,ref_img_50_back,ref_img_100_back,ref_img_200_back};
    
    %% Zapis do bazy danych
    % Ten fragment programu jest u¿ywany do stworznia bazy 
    %ref_img_gray_front = rgb2gray(ref_img_10_front);
    %ref_img_gray_back = rgb2gray(ref_img_10_back);
    %ref_pts_front = detectSURFFeatures(ref_img_gray_front);
    %ref_pts_back = detectSURFFeatures(ref_img_gray_back);
    %ref_pts_top_5000_front = ref_pts_front.selectStrongest(5000);
    %ref_pts_top_5000_back = ref_pts_back.selectStrongest(5000);
    %[ref_features,  ref_validPts] = extractFeatures(ref_img_gray_front,  ref_pts_top_5000_front);
    %dlmwrite('10_BASE_FRONT_FEATURES.csv', ref_features,'precision',8)
    %dlmwrite('10_BASE_FRONT_POINTS.csv', ref_validPts.Location,'precision',8)
    %[ref_features,  ref_validPts] = extractFeatures(ref_img_gray_back,  ref_pts_top_5000_back);
    %dlmwrite('10_BASE_BACK_FEATURES.csv', ref_features,'precision',8)
    %dlmwrite('10_BASE_BACK_POINTS.csv', ref_validPts.Location,'precision',8)
    %figure; imshow(ref_img)
    %hold on; plot(ref_pts.selectStrongest(500));
    %% Wczytanie bazy danych
    
    front_10_features = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\10_BASE_FRONT_FEATURES.csv');
    front_10_validPts = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\10_BASE_FRONT_POINTS.csv');
    back_10_features = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\10_BASE_BACK_FEATURES.csv');
    back_10_validPts = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\10_BASE_BACK_POINTS.csv');
    
    front_20_features = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\20_BASE_FRONT_FEATURES.csv');
    front_20_validPts = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\20_BASE_FRONT_POINTS.csv');
    back_20_features = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\20_BASE_BACK_FEATURES.csv');
    back_20_validPts = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\20_BASE_BACK_POINTS.csv');
    
    front_50_features = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\50_BASE_FRONT_FEATURES.csv');
    front_50_validPts = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\50_BASE_FRONT_POINTS.csv');
    back_50_features = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\50_BASE_BACK_FEATURES.csv');
    back_50_validPts = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\50_BASE_BACK_POINTS.csv');
    
    front_100_features = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\100_BASE_FRONT_FEATURES.csv');
    front_100_validPts = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\100_BASE_FRONT_POINTS.csv');
    back_100_features = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\100_BASE_BACK_FEATURES.csv');
    back_100_validPts = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\100_BASE_BACK_POINTS.csv');
    
    front_200_features = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\200_BASE_FRONT_FEATURES.csv');
    front_200_validPts = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\200_BASE_FRONT_POINTS.csv');
    back_200_features = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\200_BASE_BACK_FEATURES.csv');
    back_200_validPts = dlmread('D:\PWR\Obrazki\Projekt\Baza banknotów\200_BASE_BACK_POINTS.csv');

    %% Wykrycie punktów charakterystycznych na zdjêciu wczytanym
    image = imread(img_location);
    I = rgb2gray(image);

    % Detect features
    I_pts = detectSURFFeatures(I);
    %I_pts_top_500 = I_pts.selectStrongest(500);
    [I_features, I_validPts] = extractFeatures(I, I_pts);
    figure(1)
    imshow(image);
    title('Wczytane zdjêcie - 100 najmocniejszych punktów');
    hold on; plot(I_pts.selectStrongest(100));

%% Porównanie obrazu bazowego ze wczytanym obrazem
    % W tej sekcji dokonujemy porównania znalezionych punktów
    % charakterystycznych na wczytanym obrazie, z tymi znalezionymi na obrazie
    % bazowym.
    base_features_front={front_10_features,front_20_features,front_50_features,front_100_features,front_200_features,back_10_features,back_20_features,back_50_features,back_100_features,back_200_features};
    base_valid_points_front = {front_10_validPts, front_20_validPts, front_50_validPts, front_100_validPts, front_200_validPts,back_10_validPts, back_20_validPts, back_50_validPts, back_100_validPts, back_200_validPts};

    [banknot, indeksy_par] = find_best_match(base_features_front, I_features);

    temp_valid_points = cell2mat(base_valid_points_front(banknot));
    pasujace_punkty_na_zdjeciu_bazowym = temp_valid_points(indeksy_par(:,1),:);
    pasujace_punkty_na_zdjeciu_wczytanym = double(I_validPts(indeksy_par(:,2)).Location);
    figure(2)
    showMatchedFeatures(image, cell2mat(ref_images(banknot)), pasujace_punkty_na_zdjeciu_wczytanym, pasujace_punkty_na_zdjeciu_bazowym, 'montage');
    title('Wsztskie pary punktów charakterystycznych');
    legend('Pasujace punkty na zdjêciu bazowym','Pasujace punkty na zdjêciu wczytanym');

    %% Geometryczna transformacja obiektów
    % W tej sekcji za pomoc¹ algorytmu RANSAC odsiewamy pary które mogê
    % znajdowaæ siê poza badanym elementem
    % Zakomentowany kod to stara wersja tego algorytmu któr¹ mo¿na
    % wykorzystaæ do wyrysowania obszaru który zajmuje banknot

    %gte = vision.GeometricTransformEstimator; 
    %gte.Method = 'Random Sample Consensus (RANSAC)';
    %[tform_matrix, indeks_dopasowanego_punktu] = step(gte, pasujace_punkty_na_zdjeciu_bazowym, pasujace_punkty_na_zdjeciu_wczytanym);
    %dopasowane_punkty_na_zdjeciu_bazowym = pasujace_punkty_na_zdjeciu_bazowym(indeks_dopasowanego_punktu,:);
    %dopasowane_punkty_na_zdjeciu_wczytanym = pasujace_punkty_na_zdjeciu_wczytanym(indeks_dopasowanego_punktu,:);
    %figure;showMatchedFeatures(image, cell2mat(ref_images(banknot)), dopasowane_punkty_na_zdjeciu_wczytanym, dopasowane_punkty_na_zdjeciu_bazowym, 'montage');
    %title('Showing match only with Inliers');
    
    [tform,dopasowane_punkty_na_zdjeciu_wczytanym,dopasowane_punkty_na_zdjeciu_bazowym] = ...
    estimateGeometricTransform(pasujace_punkty_na_zdjeciu_wczytanym,pasujace_punkty_na_zdjeciu_bazowym, ...
    'similarity');

    %% Transformacja rogów obiektu
    % W tej sekcji okreœlane s¹ rogi banknotu a nastêpnie na obraz nak³adany
    % jest kszta³t zaznaczaj¹cy po³o¿enie obiektu na obrazku

    %tform = maketform('affine',macierz_tform);
    [width, height,~] = size(cell2mat(ref_images(banknot)));
    corners = [0,0;height,0;height,width;0,width];
    [x,y] = transformPointsInverse(tform, corners(:,1),corners(:,2));
    figure(3)
    imshow(image);
    patch(x,y,[0 1 0],'FaceAlpha',0.5);
    title('Banknot na obrazie wczytanym');
    
    end
