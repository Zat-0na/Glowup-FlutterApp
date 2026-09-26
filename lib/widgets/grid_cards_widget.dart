import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridCardsWidget<T> extends StatefulWidget {
  final List<T> items;

  final int Function(T item) getId;
  final String Function(T item) getTitle;
  final String Function(T item) getImage;

  final void Function(T item)? onItemTap;

  final void Function(List<T> selectedItems)? onItemsSelected;

  const GridCardsWidget({
    super.key,
    required this.items,
    required this.getId,
    required this.getTitle,
    required this.getImage,
    this.onItemTap,
    this.onItemsSelected,
  });

  @override
  State<GridCardsWidget<T>> createState() => _GridCardsWidgetState<T>();
}

class _GridCardsWidgetState<T> extends State<GridCardsWidget<T>> {
  final List<T> _selectedItems = [];

  bool _isSelected(T item) {
    return _selectedItems.any(
      (selectedItem) => widget.getId(selectedItem) == widget.getId(item),
    );
  }

  void _toggleSelection(T item) {
    setState(() {
      final index = _selectedItems.indexWhere(
        (selectedItem) => widget.getId(selectedItem) == widget.getId(item),
      );

      if (index != -1) {
        _selectedItems.removeAt(index);
      } else {
        _selectedItems.add(item);
      }
    });
  }

  @override
  void didUpdateWidget(covariant GridCardsWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Remove selected items that no longer exist
    // in the new library list.
    _selectedItems.removeWhere(
      (selectedItem) => !widget.items.any(
        (item) => widget.getId(item) == widget.getId(selectedItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Center(
        child: Text(
          'No items available',
          style: TextStyle(fontSize: 14.sp, fontFamily: 'Rubik'),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.only(
              left: 18.w,
              right: 18.w,
              top: 150.h,
              bottom: 100.h,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];

              final selected = _isSelected(item);

              return GestureDetector(
                onTap: () {
                  if (widget.onItemTap != null) {
                    widget.onItemTap!(item);
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7F7),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: selected
                              ? const Color(0xFF445E75)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.r),
                              ),
                              child: Image.asset(
                                widget.getImage(item),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Text(
                              widget.getTitle(item),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: GestureDetector(
                        onTap: () {
                          _toggleSelection(item);
                        },
                        child: Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selected
                                ? const Color(0xFF445E75)
                                : Colors.white,
                            border: Border.all(
                              color: const Color(0xFF445E75),
                              width: 1.5,
                            ),
                          ),
                          child: selected
                              ? Icon(
                                  Icons.check,
                                  size: 18.sp,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        if (_selectedItems.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 80.h),
            child: SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  widget.onItemsSelected?.call(List<T>.from(_selectedItems));

                  setState(() {
                    _selectedItems.clear();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF445E75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 52, 72, 88), // لون الإطار أبيض
                      width: 5, // سمك الإطار (تقدر تغييره حسب رغبتك)
                    ),
                  ),
                ),
                child: Text(
                  'Add Selected',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
