import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget ProfileSkeleton(BuildContext context){
  return Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: Colors.white,
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.width / 4,
              width: MediaQuery.of(context).size.width / 4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: MediaQuery.of(context).size.width / 18,
              width: MediaQuery.of(context).size.width/2,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: MediaQuery.of(context).size.width / 18,
              width: MediaQuery.of(context).size.width/2,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: MediaQuery.of(context).size.width / 18,
              width: MediaQuery.of(context).size.width/2,
              color: Colors.grey,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4,20,0,20),
              child: Container(
                height: MediaQuery.of(context).size.width / 18,
                width: MediaQuery.of(context).size.width/2,
                color: Colors.grey,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: MediaQuery.of(context).size.width / 10,
                  width: MediaQuery.of(context).size.width/10,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: MediaQuery.of(context).size.width / 10,
                  width: MediaQuery.of(context).size.width/10,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: MediaQuery.of(context).size.width / 10,
                  width: MediaQuery.of(context).size.width/10,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: MediaQuery.of(context).size.width / 10,
                  width: MediaQuery.of(context).size.width/10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4,20,0,20),
              child: Container(
                height: MediaQuery.of(context).size.width / 18,
                width: MediaQuery.of(context).size.width/2,
                color: Colors.grey,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: MediaQuery.of(context).size.width / 10,
                  width: MediaQuery.of(context).size.width/4,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: MediaQuery.of(context).size.width / 10,
                  width: MediaQuery.of(context).size.width/4,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: MediaQuery.of(context).size.width / 10,
                  width: MediaQuery.of(context).size.width/4,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}