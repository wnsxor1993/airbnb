
insert into room (city, country, state, street, zipcode, average_grade, description, name, price, check_in_time,
                  check_out_time, number_of_bathroom, number_of_bed, number_of_bedroom, room_type, host_id)
VALUES ('종로구', '한국', '서울시', '짱짱로', 1234, 3, '짱짱이에요', '[독채한옥] 도심속 고요한 휴식의 공간, 서울의하루 가회동', 196714, 14, 10, 2, 2, 2,
        'RESIDENCE', 1),
       ('광주시', '한국', '경기도', '선을로', 1234, 4, '칭찬해요', '오포숲-숲뷰 맛집/넷플릭스/무료주차공간/매일 소독/서현10분', 100714, 15, 11, 2, 2, 2, 'SHARE_HOUSE', 1);

insert into room_image (image_path, room_id)
values ('https://a0.muscache.com/im/pictures/miso/Hosting-22724133/original/8514626f-60c8-4118-b207-b25285305915.jpeg?im_w=960',
        1),
       ('https://a0.muscache.com/im/pictures/miso/Hosting-22724133/original/a98f70e9-a56e-41cd-9363-2656dfccb353.jpeg?im_w=720',
        1),
       ('https://a0.muscache.com/im/pictures/miso/Hosting-22724133/original/551e045b-8e9f-4c78-aa18-b32d6388ab59.jpeg?im_w=720',
        1),
       ('https://a0.muscache.com/im/pictures/5a6d01a9-3ba3-457c-a504-de665e65057d.jpg?im_w=960', 2),
       ('https://a0.muscache.com/im/pictures/ca4d3ad4-5bec-4643-83f5-785a7e8afc1e.jpg?im_w=720', 2),
       ('https://a0.muscache.com/im/pictures/d29bb793-e264-422a-9a2b-96f5377f4153.jpg?im_w=720', 2);

insert into host (name)
values ('meenzino'),
       ('phil');


